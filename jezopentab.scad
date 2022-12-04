
include <./lib/chamfered_cylinder.scad>;
include <./lib/hulled_objects.scad>;
include <./lib/roundedcube.scad>;

thickness=4;
three_finger_width=65;
bolt_slot_width=4;

base_plate=true;

thumb_plate=false;
thumb_plate_y_pos=three_finger_width*0.76;

bolt_on_thumb_plate=true;
botp_length=25;
botp_depth=18;
botp_height_mod=0.38;
botp_height=three_finger_width*botp_height_mod;

palm_plate=true;
palm_plate_length_mod=1.8;
palm_plate_depth=14;


depth=three_finger_width*0.6;
slot_depth=thickness+4;
z_slot_offset=2;
tilted_slot_count=6;
tilted_slot_gap=(three_finger_width * 0.8) / tilted_slot_count;
tilted_slot_angle=15;
tilted_slot_length=9;

if (base_plate) {
  union() {
    difference() {
      base_plate(depth, three_finger_width, thickness);
      translate([depth*0.6, three_finger_width*0.68, z_slot_offset]) {
        bar(depth/4, bolt_slot_width, slot_depth, 0);
      }
      translate([depth*0.75, 10, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
      translate([depth*0.75, three_finger_width*0.87, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
      elastic_slot(4);
      elastic_slot(17);
      elastic_slot(21);
      elastic_slot(three_finger_width*0.95);

      for (slot=[1:1:tilted_slot_count]) {
        tilted_slot(7, tilted_slot_gap*slot, tilted_slot_angle);
      }
    }
  }
}

  if (thumb_plate) {
    thumb_plate(0, thumb_plate_y_pos, 1, 1);
  }

  if (palm_plate) {
    x_size = three_finger_width*0.25;
    palm_plate(x_size, palm_plate_length_mod, palm_plate_depth);
  }

  if (bolt_on_thumb_plate) {
    bolt_on_thumb_plate(botp_length, botp_depth, botp_height);
  }

// Modules below

module palm_plate(radius, length_mod, palm_depth) {
  // translate([-width*0.5,width,0]) { 
  translate([-50,0,0]) {
  cube_length=radius*length_mod;
  difference() {
    union() {
      roundedcube(size=[cube_length,radius*1.5,thickness+1], radius=2);
      translate([0,radius*0.75,0]) {
        chamfercyl(radius,palm_depth,-2,-palm_depth/2);
      }
      translate([cube_length,radius*0.75,0]) {
        chamfercyl(radius*0.75,thickness+1,-2,-2);
      }
    }
    tilted_slot(cube_length-4, tilted_slot_gap-2, tilted_slot_angle);
    tilted_slot(cube_length-4, (tilted_slot_gap*2)-2, tilted_slot_angle);
  }
  }
}

module bolt_on_thumb_plate(tp_length, tp_depth, tp_height) {
  translate([-30,30,0]) {
    mount_plate_length=tp_length*0.75;
    slot_pos_x=(mount_plate_length-tilted_slot_length)/2;
    tp_y_mod=tp_height*0.4;
    union() {
      difference() {
        union() {
          translate([0, tp_y_mod, 0]) {
            roundedcube(size=[mount_plate_length,tp_height-tp_y_mod, thickness], radius=2);
          }
          translate([mount_plate_length*0.5, tp_y_mod, 0]) {
            chamfercyl(mount_plate_length*0.5,thickness,-2,-2);
          }
          fillet_length=mount_plate_length*0.8;
          fillet_pos=(mount_plate_length-fillet_length)/2;
          translate([fillet_pos, tp_height-(thickness*0.8), thickness*0.8]) {
            rotate([0, 0, 180]) {
              rotate([0, 270, 0]) {
                myfillet(fillet_length, 4);
              }
            }
          }
        }
        tilted_slot(slot_pos_x, tilted_slot_gap, -tilted_slot_angle);
        tilted_slot(slot_pos_x, tilted_slot_gap*2, -tilted_slot_angle);
      }
      translate([0, tp_height, 0]) {
        rotate([90, 0, 0]) {
          intersection() {
            roundedcube(size=[tp_length, tp_depth, thickness], radius=2);
            translate([tp_length*0.65, -tp_depth*0.4, 0]) {
              chamfercyl(tp_length, thickness, -2, -2);
            }
          }
        }
      }
    }
  }
}


module thumb_plate(x_pos, y_pos, x_scale, y_scale) {
  length=30;
  width=30;
  height=thickness-2;
  union() {
    translate([x_pos, y_pos, 0]) {
      translate([-2, 0, 22]) {
        rotate([-90, 0, 0]) {
          half_tulip_plate(length, width, height);
        }
      }

      translate([length*1.2, 3, thickness*0.8]) {
        rotate([0, 270, 0]) {
          myfillet(length, 4);
        }
      }

      translate([length*0.65, 1, thickness*0.8]) {
        rotate([0, 270, 0]) {
          rotate([0, 0, 270]) {
            myfillet(length*0.45, 6);
          }
        }
      }
    }
  }
}


module myfillet(length, side) {
  centre=side+3;
  radius=centre*2;
    difference() {
      cube([side,side,length]);
      translate([side+1,side+1,-1]) {
      cylinder(length+2,side,side,$fn=200);
      }
    }
}


module half_tulip_plate(length, width, height) {
  difference() {
  intersection() {
    translate([36,80,0]) { chamfercyl(80,height+2,-3,-3); }
    translate([36,-50,0]) { chamfercyl(80,height+2,-3,-3); }
    translate([16,15,0]) { chamfercyl(25,height+2,-3,-3); }
    translate([28,15,0]) { chamfercyl(25,height+2,-3,-3); }
    }
    translate([0,width*0.6,-1]) {
      cube([length*2,length,height+4]);
    }
  }
}

module tilted_slot(xoffset, yoffset, angle) {
  translate([xoffset,yoffset,z_slot_offset]) {
    rotate([0,0,angle]) {
      bar(tilted_slot_length,bolt_slot_width,slot_depth,0);
    }
  }
}

module elastic_slot(yoffset) {
  translate([depth*0.6,yoffset,z_slot_offset]) {
    bar(10,1.5,slot_depth,0);
  }
}

module base_plate(depth, height, thickness) {
  intersection() {
    intersection() {
      union() {
        roundedcube(size=[depth,height,thickness], radius=1);
        difference() {
          top_corner_x=depth*1.15;
          top_corner_y=height*0.55;
          roundedcube(size=[top_corner_x,top_corner_y,thickness], radius=1);
          translate([top_corner_x, top_corner_y]) {
            chamfercyl(depth*0.15, thickness, b=1, t=1);
          }
        }
      }
      translate([depth*0.8, depth*0.01]) {
        chamfercyl(height, thickness, b=-1, t=-1);
      }
    }
    translate([depth*0.7, depth*1.1]) {
      chamfercyl(height, thickness, b=-1, t=-1);
    }
    translate([depth*0.6, depth*1.65]) {
      chamfercyl(height, thickness, b=-1, t=-1);
    }
  }
}


// module chamfercyl(
//    r,              // cylinder radius
//    h,              // cylinder height
//    b=0,            // bottom chamfer radius (=0 none, >0 outside, <0 inside)
//    t=0,            // top chamfer radius (=0 none, >0 outside, <0 inside)
//    offset=[[0,0]], // optional offsets in X and Y to create
//                    // convex hulls at slice level
//    slices=10,      // number of slices used for chamfering
//    eps=0.01,       // tiny overlap of slices
