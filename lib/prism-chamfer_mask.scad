//===========
//  Modules
//===========

//Create masks for 1 or more prism edges and any corners in between.
//See "prism-chamfer_demo.scad" for a description of the arguments.
module prism_chamfer_mask(polygon_pts, start_edge=0, end_edge=0, height=0,
                          side=1, side2=0, corner_slope="medium") {
  num_pts = len(polygon_pts);
  assert(num_pts >= 3);
  assert(end_edge >= start_edge);
  // Allow specifying edges past the first point, in the -ve or +ve direction,
  // up to but not including a complete rotation. Allows the corner at the
  // first point to be included in a contiguous range.
  assert(start_edge > -num_pts && end_edge < 2*num_pts);

  points = [ for(i = [start_edge:end_edge+1])
             [polygon_pts[mod(i,num_pts)].x, polygon_pts[mod(i,num_pts)].y, height] ];

  cw = is_polygon_orientation_clockwise(polygon_pts);

  include_start = is_vertex_convex(vertex_points(polygon_pts, start_edge), cw);
  include_end   = is_vertex_convex(vertex_points(polygon_pts, end_edge+1), cw);

  prism_chamfer_mask_raw(points, side, side2, cw,
                         corner_slope  = corner_slope,
                         include_start = include_start,
                         include_end   = include_end);
}

//Create masks for 1 or more prism edges and any corners inbetween,
//but their points and end conditions must be specified.
module prism_chamfer_mask_raw(points, side=1, side2=0, cw=false, top=undef,
                              corner_slope="medium", include_start=false, include_end=false) {
  num_points = len(points);
  assert(num_points>1);
  for(i = [0:num_points-2]) {
    prism_chamfer_mask_e(points[i], points[i+1], side, side2, cw, top,
                         include_p0 = i==0            ? include_start : true,
                         include_p1 = i==num_points-2 ? include_end   : true);

    if(i<num_points-2) {
      prism_chamfer_mask_c(points[i], points[i+1], points[i+2], side, side2, cw, top,
                           slope = corner_slope);
    }
  }
}

//Create a chamfer mask for a single prism edge.
module prism_chamfer_mask_e(p0, p1, side=1, side2=0, cw=false, top=undef,
                            include_p0=true, include_p1=true) {
  side2 = side2 == 0 ? side : side2;    //set sides equal unless side2 is specified
  top = is_undef(top) ? p0.z > 0 : top; //set top to positivity of z unless specified
  assert(p0.z == p1.z); //only points in the same x-y plane are supported
  assert(side>0 && side2>0);
  assert(p0!=p1);

  //Conditional transforms don't seem to be supported. Fortunately mirror
  //seems to be a nop if the argument is [0,0,0], so we can use a variable
  //and this dodgy conditional assignment construct instead:
  mr_args = (!top &&  cw) ? [[1,0,0],[ 90,0,-90]] : //bottom, cw
            ( top &&  cw) ? [[0,0,0],[-90,0,-90]] : //top, cw
            ( top && !cw) ? [[1,0,0],[-90,0, 90]] : //top, ccw
                            [[0,0,0],[ 90,0, 90]];  //bottom, ccw

  length = norm(p1-p0) + (include_p0?ff:-ff) + (include_p1?ff:-ff);
  p0_fudged = translate_towards(p0, p1, include_p0?-ff:ff); //shift p0 fwd or back by fudge factor
  translate(p0_fudged) rotate([0, 0, angle_of(p0, p1)]) //align with p0 -> p1
    mirror(mr_args[0]) rotate(mr_args[1]) //orient to x-y plane, in +x direction
      linear_extrude(height=length)
        polygon([[-ff,-ff],[side,-ff],[-ff,side2]]);
}

//Create a chamfer mask for the corner between two prism edges.
module prism_chamfer_mask_c(p0, p1, p2, side=1, side2=0, cw=false, top=undef,
                            slope="medium") {
  side2 = side2 == 0 ? side : side2;    //set sides equal unless side2 is specified
  top = is_undef(top) ? p0.z > 0 : top; //set top to positivity of z unless specified
  assert(p0.z == p1.z && p1.z == p2.z); //only points in the same x-y plane are supported
  assert(side>0 && side2>0);
  assert(p0!=p1 && p1!=p2 && p0!=p2);

  corner_angle = corner_angle(p0, p1, p2);

  if(is_vertex_convex([p0,p1,p2],cw)) {
    //no mask needed for outside corners
  }
  else if(slope=="deep") {    //then carve out as much as possible
    intersection() {
      //Just extend the two edge chamfers so they overlap fully.
      prism_chamfer_mask_e(p1, translate_towards(p1,p0,-side), side, side2, cw, top);
      prism_chamfer_mask_e(translate_towards(p1,p2,-side), p1, side, side2, cw, top);
    }
  }
  else if(slope=="shallow") { //then carve out as little as possible. Inspired by corner-tools.scad
    translate(p1) rotate([0, 0, corner_angle])
      rotate([0, 0, 45]) //rotate to put it symmetrical around the x axis
        polyhedron(points = [[-ff,-ff,ff], [side,-ff,ff], [-ff,side,ff], [-ff,-ff,-side2]],
                   faces  = [[0,2,1], [0,1,3], [0,3,2], [1,2,3]],
                   convexity = 100);
  }
  else {                      //otherwise, do a "medium" half-way corner
    c0 = [p1.x - side*cos(corner_angle), p1.y - side*sin(corner_angle), p1.z];
    c1 = [p1.x + side*cos(corner_angle), p1.y + side*sin(corner_angle), p1.z];
    intersection() {
      //Same as "deep", but also intersect a third mask with angle half-way between
      //the first two. c0 and c1 just extend the edge either side of the corner point.
      prism_chamfer_mask_e(p1, translate_towards(p1,p0,-side), side, side2, cw, top);
      prism_chamfer_mask_e(translate_towards(p1,p2,-side), p1, side, side2, cw, top);
      prism_chamfer_mask_e(c0, c1, side, side2, cw, top);
    }
  }
}
// end third party modules


