include <./lib/chamfer_extrude.scad>;
include <./lib/prism-chamfer.scad>;
include <./lib/third_party_modules.scad>;

/* [Global User Variables] */

// This will lay items out on plate. If you are working on one item, unset.
multiple_items=false;

thickness=4.1;
three_finger_width=70;
plate_bolt_slot_width=92;
bolt_slot_width=5.5;
bolt_head_width=10.0;
elastic_slot_width=2.0;

/* [Initials] */
// text as defined below, custom requires your own coding
initials_type="text";  // ["text","custom"]
initials="JM";
initials_font="Liberation Sans"; // ["Liberation Mono", "Liberation Sans", "Liberation Serif","Arial Black","Courier","Inconsolata","Cantarell","Droid Sans"]
initials_size=7; // [2,3,4,5,6,7,8,9,10,11,12,13,14,15,20,25]
initials_style="Bold"; // ["Regular","Italic","Bold","Light","Plain","ExtraBold"]

// the type of label information on various parts
label_type="part"; // ["full","part","none"]

// saves mirroring some objects in the slicer
right_handed=false;

// thickness of various plates in the system
mount_plate_thickness=4.1;

depth=three_finger_width*0.6;
slot_depth=thickness+4;
z_slot_offset=2;
tilted_slot_gap=8.6;
tilted_slot_angle=15.0;
tilted_slot_length=9.0;


/* [Items] */
finger_ring_with_spacer=false;
// greater than 0 shifts ring and spacer forward
ring_forward_mod=2.0;

bb_finger_ring=false;

/* [Tab BB Plate] */
// Barebow plate with fingernail slots for stringwalking
tab_bb_plate=false;

// desired tab width 
bb_tab_width=23;

// diameter of hole for wire crawl_guides
bb_guide_hole_diameter=1.1;
// how far apart the slots are
bb_guide_hole_spacing=1.2;
// fine adjust holes
bb_guide_hole_vertical_mod=0.4;
// move ledge relative to holes
bb_ledge_vertical=-0.01;
// how thick the ledge at front of tab is
bb_ledge_thickness=2.1;
// how wide the ledge at the front is
bb_ledge_width=8.8;
// Long thumbnail slot/groove for bb tab stringwalking marks 
bb_long_slot_len=5.1;
// short thumbnail slot/groove for bb tab stringwalking marks 
bb_short_slot_len=4.2;

// short how deep the grooves are. 0=full depth. 1=none
bb_slot_depth=0.4;


// width of shallow slot for putting distance marks
bb_tape_slot_width=6.1;

// depth of shallow slot for putting distance marks
bb_tape_slot_depth=0.6;

// manual tweak to move tape slot laterally
bb_tape_slot_adjust=1.6;

// manual tweak to move mount holes laterally
bb_mount_holes_lateral_mod=0.1;
//
// Barebow plate created outside of OpenScad, has nicely chamfered edges
mins_bb_plate=false;

/* [Pinky Trigger] */
pinky_trigger=false;
// Pinky Trigger Shape
pinky_trigger_shape="2"; // ["1","2"]
// reversed puts the peg behind the bolt
pinky_trigger_bolt_front=true;
// set this to false to have two bolt holes rather than a locating pin and a hole
pinky_trigger_pin=true;

/* [Palm Plate] */
palm_plate=false;
palm_plate_length_mod=1.8;
palm_plate_depth=14;

/* [Palm Washer] */
palm_washer=false;
palm_washer_depth=5;
palm_washer_radius=15;

/* [Round Palm Plate] */
round_palm_plate=false;

/* [Wedge Palm Plate] */
wedge_palm_plate=false;

/* [Bolt-On Mount Plate] */
// base mount plate for a chin or thumb plate to join onto
bolt_on_plate=false;
bolt_on_plate_with_fillet=false;
bop_slot_angle=4;
bop_slot_width=5.5;
bop_width=20;
// bolt-on-thumb-plate thickness
bop_thickness=4;
// bolt-on-thumb-plate height proportion to main plate size
bop_height=30;
// base mount plate for a chin or thumb plate to join onto

/* [Bolt-On Bar] */
// rounded bar for mounting a pad or rest, has divider for strength

// view detail for preview render (you want this low to be fast)
preview_fn=26;
// preview_fa=6;
// preview_fs=0.5;
// view detail for final render (this should be higher for quality)
render_fn=95;
// render_fa=1;
// render_fs=0.5;

$fn = $preview ? preview_fn : render_fn;
// $fa = $preview ? preview_fa : render_fa;
// $fs = $preview ? preview_fs : render_fs;

if (finger_ring_with_spacer) {
 translate(get_translation(22))
 rotate([0, 180, 0])
 finger_ring_with_spacer();
}

if (tab_bb_plate) {
  translate(get_translation(23)) tab_bb_plate();
}

if (mins_bb_plate) {
  translate(get_translation(24)) mins_bb_plate();
}

if (bb_finger_ring) {
  translate(get_translation(25))
   rotate([0, 180, 0])
  bb_finger_ring();
}




module bb_base_plate(scaling, plate_height=thickness, slots=true, x_chamfer_offset=3, x_chamfer_size_mod=1.05) {

      z_miror = right_handed ? -1 : 1;

      mirror([0,0,z_miror])
      difference() {
        // base polygon, hulled and scaled
        chamfered_polygon(polygon_points);

        // bolt holes to secure tab
        if (slots) {
          holes_x_offset=bb_mount_holes_lateral_mod+(27+ring_forward_mod);
          for (slotno=[0:1:2]) {
           y_pos = 13*scaling + (slotno * (52*scaling));
           x_pos = holes_x_offset*scaling;
           if (slotno == 1) {
               x_pos = (holes_x_offset - 15) *scaling;
               initial_translation = right_handed ? thickness/2 : -thickness*1.5;
                translate([x_pos-1, y_pos-2, initial_translation]) {
                  cube([5, 15, 4]);
                }
            } else {
                angled_slot(x_pos, y_pos, slot_angle=90, slot_length=10*scaling, slot_width=bolt_slot_width, thickness=10);
            }
          }
        } else {
          translate([holes_x_offset*scaling, 22*scaling, -slot_depth]) {
            cylinder(slot_depth*2, bolt_slot_width*0.55, bolt_slot_width*0.55);
          }
          translate([holes_x_offset*scaling, 120*scaling, -slot_depth]) {
            cylinder(slot_depth*2, bolt_slot_width*0.55, bolt_slot_width*0.55);
          }
        }
      }

    polygon_points = [
      // middle and ring finger front
      [64,127], [64,3],
      // bottom front curve
      [61,0],[31,1],[20,5],
      // rear bottom join
      [7,20], [0,39],
      // top rear corner
      [20,132], [22,134], [26,136],
      // top
      [48,140],[62,140],[64,138]
    ];

  module chamfered_polygon(points) {
      resize([bb_tab_width, three_finger_width, thickness]) {
      union() {
        //  bottom layer (not slanted)
        linear_extrude(height = plate_height/2) {
          polygon(points);
        }
        // top layer (slanted)
        hull() {
          linear_extrude(height = 0.1) {
            polygon(points);
          }
          translate([x_chamfer_offset,0,-plate_height/4]) {
            scale([x_chamfer_size_mod, 1, 1]) {
              linear_extrude(height = 0.5) {
                polygon(points);
              }
            }
          }
        }
      }
    }
  }

  module chamfered_polygon_old() {
    difference() {
      linear_extrude(height = plate_height) {
        polygon(polygon_points, convexity=2);
      }
      prism_chamfer_mask(polygon_points,
      start_edge=0,
      end_edge=13,
      side=2,
      side2=0
     //  height=plate_height,
     // side=1.0,  corner_slope="medium"
     );
    }
  }


}


module fillet(length, side) {
  myfillet(length, side) ;
}

module myfillet(length, side) {
  centre=side+3;
  radius=centre*2;
    difference() {
      cube([side,side,length]);
      translate([side+1,side+1,-1]) {
      cylinder(length+2,side,side);
      }
    }
}


module finger_spacer_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_spacer_length, ring_spacer_width, right_handed) {
  inner_diameter=ring_finger_circumference/3.142;
  inner_radius=(inner_diameter/2);
  outer_radius=inner_radius+ring_thickness;
  fillet_translation=inner_radius+(ring_thickness/2);
  handedness_rotation = right_handed ? 0 : 180;
  ring_translation = right_handed ? 1-outer_radius-ring_joint_spacer_overlap : outer_radius+ring_joint_spacer_overlap-1;
  z_move = right_handed ? 0 : ring_spacer_plate_thickness/2;

  translate([0,0,z_move]) {
    rotate([handedness_rotation,0,0]) {
      // finger spacer
      resize([ring_spacer_length,ring_spacer_width,inner_diameter]) {
        rotate([0,0,spacer_rotation_degrees]) {
            import(spacer_stl_file);
        }
      }
      // finger ring
      x_move = ring_thickness-(ring_thickness * ring_spacer_length*0.5);
      translate([3,ring_translation,outer_radius-ring_vertical_height_mod]) {
        rotate([90,0,90]) {
          union() {
            //ring
            resize([0,0,ring_depth]) {
              torus(outer_radius, inner_radius);
            }
            //fillet 1
            rotate([0,180,0]) {
              translate([-fillet_translation,-fillet_translation,-(ring_depth-1)/2]) {
                myfillet(ring_depth-1, inner_radius);
              }
            }
            //fillet 2
            translate([-fillet_translation,-fillet_translation,-(ring_depth-1)/2]) {
              myfillet(ring_depth-1, inner_radius);
            }
          }
        }
      }
    }
  }
}



module angled_slot(xpos, ypos, slot_angle=30, slot_length=5, slot_width=bolt_slot_width, scaling=1, thickness=thickness) {
  slot_depth=thickness*2;
  translate([xpos*scaling,ypos*scaling,thickness/2]) {
    rotate([0,0,slot_angle]) {
      bar(slot_length,slot_width,slot_depth,0);
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

module elastic_slot(xpos, ypos, scaling=1) {
  translate([xpos*scaling,ypos*scaling,z_slot_offset]) {
    bar(10,elastic_slot_width,slot_depth,0);
  }
}



module finger_ring_with_spacer() {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;

  ring_x_offset=92+ring_forward_mod;
  ring_y_offset=100;
  info("finger_ring_with_spacer");
  info(str(
  spacer_stl_file,
  "_c", ring_finger_circumference,
  "_th", ring_thickness,
  "_dp", ring_depth,
  "_l", ring_spacer_length,
  "_w", ring_spacer_width,
  "_deg", spacer_rotation_degrees,
  "_fm", ring_forward_mod,
  "_hm", ring_vertical_height_mod,
  "_ov", ring_joint_spacer_overlap,
  "_vm", ring_vertical_mod
  ));
  union() {
    difference() {
      ring_base_plate(scaling, ring_spacer_plate_thickness, "base");

      // bolt holes to secure tab
      translate([100*scaling, 30*scaling, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
        translate([0, plate_bolt_slot_width*scaling, 0]) {
          cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
        }
      }
    }

    translate([ring_x_offset*scaling,(ring_y_offset*scaling)+ring_vertical_mod,0]) {
      rotate([0,0,0]) {
        finger_spacer_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_spacer_length, ring_spacer_width, right_handed);
      }
    }
  }
}

module finger_ring_label(label_type) {
    linear_extrude(height = thickness*2) {
      hand_label = right_handed ? "R" : "L";
      if (label_type == "full") {
        label = str(ring_finger_circumference, "/", ring_thickness, "/", ring_depth, "/", three_finger_width, "/", hand_label, "/", ring_spacer_width);
        text(label, font = initials_font, halign="center", size=5 );
      } else if (label_type == "part") {
        label = str(ring_finger_circumference, "/", ring_thickness);
        text(label, font = initials_font, halign="center", size=7 );
      }
  }
}

module ring_base_plate(scaling, plate_height=thickness, label_type="full") {
  scale([scaling, scaling, 1]) {
    translate([100, 40, 1]) {
      rotate([0, 0, 90]) {
        difference() {
          hull() {
            bar(70,51,plate_height/2,0);
            translate([1, 1, -plate_height/2]) {
              bar(60,40,1,0);
            }
          }
          if (label_type!="none") {
            rotate([180,0,0])
            translate([35, -22, 1]) finger_ring_label(label_type);
          }
        }
      }
    }
  }
}


module bb_finger_ring() {
  // Tab sketch is 144px high
  // Tab is 65px high
  // This is from tab with three_finger_width=65
  pic_scale=65/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;

  ring_x_offset=36+ring_forward_mod;
  ring_y_offset=100;
  z_move = right_handed ? ring_spacer_plate_thickness : -ring_spacer_plate_thickness;

  union() {
    translate([0,0,z_move])
    mirror([0,0,1]) bb_base_plate(scaling, ring_spacer_plate_thickness, slots=false);

    translate([ring_x_offset*scaling,ring_y_offset*scaling,0]) {
      rotate([0,0,0]) {
        finger_ring(ring_finger_circumference, ring_thickness, ring_depth);
      }
    }
  }
}

module finger_ring(ring_finger_circumference, ring_thickness, ring_depth) {
  inner_diameter=ring_finger_circumference/3.142;
  inner_radius=(inner_diameter/2);
  outer_radius=inner_radius+ring_thickness;
  ring_rotation = right_handed ? 0 : 180;
  ring_translation = right_handed ? -outer_radius : outer_radius;
  fillet_translation=inner_radius+(ring_thickness*0.75);

    rotate([ring_rotation,0,0]) {
      // finger ring
      // translate([ring_thickness-2,ring_translation,inner_radius+(ring_thickness/2)]) {
      translate([0,ring_translation,outer_radius]) {
        union() {
          rotate([90,0,90]) {
            resize([0,0,ring_depth]) torus(outer_radius, inner_radius);
            //fillet 1
            rotate([0,180,0]) {
              translate([-fillet_translation,-fillet_translation,-(ring_depth-1)/2]) {
                myfillet(ring_depth-1, inner_radius);
              }
            }
            //fillet 2
            translate([-fillet_translation,-fillet_translation,-(ring_depth-1)/2]) {
              myfillet(ring_depth-1, inner_radius);
            }
          }
        }
      }
    }

}

module tab_bb_plate_old(slots=true) {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  x_scale=1.0;
  pic_scale=65/138;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  slot_spacing=bb_guide_hole_spacing;
  slot_range=129; // 144-gap for top and bottom
  number_of_slots=slot_range/slot_spacing;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {

  difference() {
  scale([x_scale,1,1])
    bb_base_plate(scaling);

    // tape slot
    translate([bb_tape_slot_adjust+(47*scaling), 6*scaling,-bb_tape_slot_depth]) {
      cube([bb_tape_slot_width, slot_range*scaling, 4]);
    }

    // fingernail slots
    for(slot = [0 : 3 : number_of_slots]) {
      long_slot = (slot % 2) == 0;
      slot_len = long_slot ? bb_long_slot_len  : bb_short_slot_len;
      fingernail_slot(69-(slot_len*2), 6+(slot*slot_spacing), thickness, slot_len, scaling=scaling);
    }


    initial_translation = right_handed ? thickness/2 : -thickness/2;
    // Initials
    translate([3, 20, initial_translation]) {
      scale([1,1,3])
      initials();
    }

  }
  slot_depth=thickness*bb_slot_depth;
  module fingernail_slot(xpos, ypos, thickness, slot_len, scaling=1) {
    translate([xpos*scaling*x_scale,ypos*scaling,slot_depth]) {
      rotate([0,5,0]) {
        bar(slot_len,1,10,0);
      }
    }
  }
}

module tab_bb_plate() {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=65/138;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  slot_spacing=bb_guide_hole_spacing+bb_guide_hole_diameter;
  top_slot_margin=2; // margin at top and bottom with no slots
  bottom_slot_margin=4; // margin at top and bottom with no slots
  slot_range=three_finger_width-top_slot_margin-bottom_slot_margin;
  number_of_slots=slot_range/slot_spacing;
  bb_bottom_thickness=0.5;
  bb_top_thickness=0.5;
  bb_guide_hole_radius=bb_guide_hole_diameter/2;
  // min thickness allows top/bottom to be 0.5mm and middle to be 1mm
  min_thickness=bb_top_thickness+bb_ledge_thickness+bb_bottom_thickness+(bb_guide_hole_diameter*2);
  guide_hole_base_vertical=bb_guide_hole_vertical_mod+bb_guide_hole_radius;
  x_scale=1.0;
  slots=true;
  // x_scale=resize_scale*bb_tab_width;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {

  difference() {
    union() {
      resize([bb_tab_width, three_finger_width, min_thickness]) {
        translate([0,0,min_thickness/2])
          bb_base_plate(scaling);
      }
      // ledge
      // translate([bb_tab_width-4, bottom_slot_margin+(slot_range/2), guide_hole_base_vertical+(bb_ledge_thickness/2)+bb_ledge_vertical]) {
      translate([bb_tab_width-4, (three_finger_width/2), guide_hole_base_vertical+(bb_ledge_thickness/2)+bb_ledge_vertical]) {
        rotate([90,0,0]) {
            bar(bb_ledge_width,bb_ledge_thickness,three_finger_width,0);
        }
      }
    }

    // wire guides
    translate([bb_tab_width/2, bottom_slot_margin, guide_hole_base_vertical ]){
      for(slot = [0 : 1 : number_of_slots]) {
        index_hole(0, slot*slot_spacing, 0, 80);
        index_hole(0, slot*slot_spacing, bb_ledge_thickness+bb_guide_hole_radius, 80);
      }
    }
    // hole at back (aka tape slot)
    translate([bb_tab_width-8+bb_tape_slot_adjust, bottom_slot_margin, bb_tape_slot_depth]) {
      // cube([bb_tape_slot_width, slot_range, 8]);
    }
  }
    module index_hole(xpos, ypos, z_pos, slot_len) {
      translate([xpos, ypos, z_pos]) {
        rotate([0,90,0]) {
          cylinder(slot_len, d=bb_guide_hole_diameter, true);
        }
      }
    }
}

module mins_bb_plate() {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=65/62;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  slot_spacing=2;
  difference() {
    translate([50,72,0]) {
      scale([scaling,scaling,scaling]) {
        rotate([180,180,0]) {
          import("mins_bb_tab_plate.stl");
        }
      }
    }
    // bolt holes to secure tab
    translate([34*scaling, 22*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
    translate([34*scaling, 60*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
  }
}

module initials() {
	font_style_text=str(initials_font,":style=",initials_style);
	if (initials_type == "custom") {
		initials_custom(font_style_text);
	} else {
		initials_text(font_style_text);
	}
}

module initials_custom(font_style) {
  rotate([0,0,0]) {
    linear_extrude(height = thickness*2) {
      translate([0, 9, 0]) {
        square([12,2]);
      }
      text("J", font=font_style, size=initials_size );
      translate([5, 1, 0]) {
        text("M", font=font_style, size=initials_size );
      }
    }
  }
}

module initials_text(font_style) {
rotation = right_handed ? 180 : 0;
  rotate([0,rotation,0]) {
    linear_extrude(height=thickness*2) {
      text(initials, font=font_style, size=initials_size );
    }
  }
}

function get_translation(item_number) =
  multiple_items ? get_translation_for_item(item_number) : get_translation_for_item(0);

// function polygon_dimensions(points) = [
//     max([p[0] for p in points]) - min([p[0] for p in points]),
//     max([p[1] for p in points]) - min([p[1] for p in points])
// ];


number_of_cols = 4;
function get_translation_for_item(item_number) = [
  80 * (item_number % number_of_cols),
  80 * floor(item_number / number_of_cols),
  0 ];


