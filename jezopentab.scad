
include <./lib/chamfered_cylinder.scad>;
include <./lib/hulled_objects.scad>;
include <./lib/roundedcube.scad>;
include <../../libs/radius_block.scad>;


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

round_palm_plate=true;

tulip_chin_plate=true;

grooved_tulip_chin_plate=true;



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

if (round_palm_plate) {
translate([60, 30, 0]) rotate([180, 0, 0])  round_palm_plate();
}

if (tulip_chin_plate) {
translate([60, 60, 0]) rotate([90, 0, 0])  tulip_chin_plate();
}

if (grooved_tulip_chin_plate) {
  translate([60, 90, 0]) rotate([90, 0, 0])  grooved_tulip_chin_plate();
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

module tulip_chin_plate() {
  module tulip_plate() {
    length=38;
    width=30;
    height=1;
    intersection() {
      radiusedblock(length,width,height,height);
      translate([36,80,0]) { chamfercyl(80,3,-2,-2, $fn=200); }
      translate([36,-55,0]) { chamfercyl(80,3,-2,-2, $fn=200); }
      translate([-length/5,-length-4,0]) { rotate([0,0,45]) {
        radiusedblock(length*2,(length*2)-3,height,height);
      } }
    }
  }

  module myfillet(length, side) {
    centre=side+3;
    radius=centre*2;
      difference() {
        cube([side,side,length]);
        translate([side+1,side+1,-1]) {
        cylinder(length+2,side,side,$fn=100);
        }
      }
  }

  module tilted_slot(xoffset) {
    translate([xoffset,-1,0]) {
      rotate([0,0,60]) {
        bar(2.5,4,12,0);
      }
    }
  }


  difference() {
    union() {
      // mounting plate
      translate([2,0,0]) {
        intersection() {
          intersection() {
            difference(){
              union() {
                // main block
                translate([0,-5,0]) {
                  radiusedblock(70,37,2.5,1);
                }
                // front block
                translate([39,20,0]) { radiusedblock(31,10,2.5,1); }
                // front block to main block taper
                translate([41,17.3,0]) { rotate([0,0,54]) { radiusedblock(9,8,2.5,1); } }
              }
              // circular front cutout
              translate([32,105,0]) { chamfercyl(80,5,2,2); }
            }
          }
            // bottom corner
            // translate([34,-60,0]) { rotate([0,0,45]) { radiusedblock(100,100,2.5,1); } }
            translate([29,-57,0]) {
              rotate([0,0,54]) {
                radiusedblock(90,90,2.5,1);
              }
            }
        }
          // translate([41,39.3,0]) { rotate([0,0,54]) { radiusedblock(9,8,2.5,1); } }
      } // end main plate and intersections

      // Thumb plate and fillets
      translate([0,-10,0]) {
        // plate
        translate([0,5,-10]) {
          rotate([90,0,90]) {
             tulip_plate();
          }
        }

        // Thumb plate fillet 1
        translate([2,16,1]) {
          rotate([-90,0,0]) {
             myfillet(23,5);
          }
        }

        // Thumb plate fillet 2
        translate([2,39,3.6]) {
          rotate([90,0,0]) {
             myfillet(23,5);
          }
        }
      } // end thumb plate and fillets

    } // end main plate union

    // All the below are removals

    tilted_slot(08);
    tilted_slot(16);
    tilted_slot(24);
    tilted_slot(32);
    tilted_slot(40);
    tilted_slot(48);
    tilted_slot(56);
    tilted_slot(64);

    // top slot on rest
    translate([10,8,0]) {
      rotate([0,0,90]) {
        bar(10,5,19,0);
      }
      // cutout for loop
      translate([5,1,-0.5]) { rotate([90,0,90]) { bar(9,4.5,12,0); } }
    }

  translate([22,0,0]) {
    // top hole for elastic
    translate([-3,7,0]) {
      hull(){
        // top
        translate([2,1,0]) { rotate([0,0,90]) { bar(9,7,12,0); } }
        // bottom
        translate([2,1,0]) { rotate([0,0,35]) { bar(14,7,12,0); } }
        // translate([8,0,0]) { rotate([0,0,83]) { bar(16,4.5,12,0); } }
      }
    }

    // mounting bolt slots
    translate([13,7.5,-1]) {
      // left slot
      bar(8,4.5,19,0);
      // right slot
      translate([6,9,0]) { bar(8,4.5,19,0); }
    }

    // large hole for finger loop fastener
      translate([33.5,7,0]) {
        hull(){
          // top
          translate([0,1,0]) { rotate([0,0,83]) { bar(14,7,12,0); } }
          // bottom
          translate([7,1,0]) { rotate([0,0,83]) { bar(14,7,12,0); } }
          // translate([8,0,0]) { rotate([0,0,83]) { bar(16,4.5,12,0); } }
        }
        // cutout for loop
        translate([13,2,0]) { rotate([90,0,90]) { bar(10,4.5,12,0); } }
      }
    } // translate

  } // end difference

}

module grooved_tulip_chin_plate() {
  $fn=100;
  module tulip_plate() {
    length=28;
    width=30;
    height=5;
    difference() {
    intersection() {
      radiusedblock(length,width,height,height);
      translate([36,80,0]) { chamfercyl(80,height+2,-3,-3); }
      translate([36,-50,0]) { chamfercyl(80,height+2,-3,-3); }
      translate([16,15,0]) { chamfercyl(25,height+2,-3,-3); }
      }

      translate([-7,9.5,16]) {
        rotate([-8,90,0]) {
          cylinder(length+20,12,14,$fn=200);
        }
      }
      }
  }

  module curved_plate() {
    length=32;
    width=15;
    height=5;
    difference() {
      intersection() {
        radiusedblock(length,width,height,height);
        translate([44,78,0]) { chamfercyl(80,height+2,-2,-4); }
        translate([20,28,0]) { chamfercyl(30,height+2,-2,-4); }
      }
      translate([-1,5,16]) {
        rotate([-3,90,0]) {
          cylinder(length+12,13,14,$fn=200);
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

  module tilted_slot(xoffset) {
    translate([xoffset,-5,0]) {
      rotate([0,0,60]) {
        bar(5,4,12,0);
      }
    }
  }


  difference() {
    union() {
      // mounting plate
      translate([2,0,0]) {
        intersection() {
          intersection() {
            difference(){
              union() {
                // main block
                translate([0,-10,0]) {
                  radiusedblock(68,32,2.5,1);
                }
                // front block
                translate([46,19,0]) { radiusedblock(22,8,2.5,1); }
                // front block to main block taper
                translate([48,14.3,0]) { rotate([0,0,54]) { radiusedblock(9,8,2.5,1); } }
              }
            }
              // top corner
                translate([44,-60,0]) { rotate([0,0,45]) { radiusedblock(100,100,2.5,1); } }
          }
            // bottom corner
            // translate([34,-60,0]) { rotate([0,0,45]) { radiusedblock(100,100,2.5,1); } }
            translate([37,-60,0]) {
              rotate([0,0,60]) {
                radiusedblock(90,90,2.5,1);
              }
            }
        }
          // translate([41,39.3,0]) { rotate([0,0,54]) { radiusedblock(9,8,2.5,1); } }
      } // end main plate and intersections

      // Thumb plate and fillets
      translate([0,-10,10]) {
        // plate
        translate([4.2,0,10]) {
          rotate([0,-90,0]) {
            rotate([0,0,90]) {
               tulip_plate();
            }
          }
        }

        // Thumb plate fillet 1
        translate([2.5,11,-9.2]) {
          rotate([-90,0,0]) {
             myfillet(22,4);
          }
        }

        // Thumb plate fillet 2
        translate([3.5,33,-6.9]) {
          rotate([90,0,0]) {
             myfillet(26,5);
          }
        }
      } // end thumb plate and fillets

    } // end main plate union

    // All the below are removals

    tilted_slot(10);
    tilted_slot(21);
    tilted_slot(31);
    tilted_slot(40);
    tilted_slot(48);
    tilted_slot(56);
    tilted_slot(64);

    // top slot on rest
    translate([10,6,0]) {
      rotate([0,0,90]) {
        bar(9,5,19,0);
      }
      // cutout for loop
      translate([5,0,0]) { rotate([90,0,90]) { bar(9,4.5,12,0); } }
    }

  translate([22,0,0]) {

    // top hole for elastic
    translate([0,6,0]) {
      // hull(){
        // top
        translate([-2,1,0]) { rotate([0,0,90]) { bar(7,7,12,0); } }
        // bottom
        translate([8,8,1]) { rotate([0,0,34]) { bar(3,7,12,0); } }
        // translate([8,0,0]) { rotate([0,0,83]) { bar(16,4.5,12,0); } }
      // }
    }

    // mounting bolt slots
    translate([13,7.5,-1]) {
      // left slot
      bar(8,4.5,19,0);
      // right slot
      translate([6,9,0]) { bar(8,4.5,19,0); }
    }

    // large hole for finger loop fastener
      translate([33.5,5.5,0]) {
        hull(){
          // top
          translate([0,2,0]) { rotate([0,0,83]) { bar(14,7,12,0); } }
          // bottom
          translate([4,2,0]) { rotate([0,0,83]) { bar(14,7,12,0); } }
          // translate([8,0,0]) { rotate([0,0,83]) { bar(16,4.5,12,0); } }
        }
        // cutout for loop
        translate([13,2,0]) { rotate([90,0,90]) { bar(10,4.5,12,0); } }
      }
    } // translate

  } // end difference

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

module round_palm_plate() {

slot_length=10;
tilt_angle=14;
length=20;

rpp_base_plate();

module rpp_base_plate() {

  difference(){
    translate([length/1.1,length/1.2,0]) {
      rotate([0,tilt_angle,00]) {
        scale([1.2, 1, 0.5]) {
          sphere(r = length);
        }
      }
    }
    translate([10-length,10-length,-1]) {
      radiusedblock(length*3,length*3,length,3);
    }
    translate([5-length,-length/2,-length]) {
        cube([length,length*2,length]);
    }
    translate([3,-13,-10]) {
      slots(13,15,0);
    }
  }
}


module slots(x,y,z) {
  translate([x,y,z]) {
      union() {
        translate([0,0,-5]) { rotate([0,0,0]) { bar(slot_length,11,22,0); } }
        translate([0,0,0]) { rotate([0,0,0]) { bar(slot_length,5,25,0); } }
        translate([5,23,-5]) { rotate([0,0,0]) { bar(slot_length+1,11,22,0); } }
        translate([5,23,0]) { rotate([0,0,0]) { bar(slot_length+1,5,25,0); } }
    }
  }
}

module cutouts() {
  rotate([0,tilt_angle,0]) {
    // rounded finger cutout
    translate([85,-35,0]) { chamfercyl(70,tilt_angle+8,3,3, $fn=100); }
  }
  rotate([0,tilt_angle,0]) {
    // rounded finger cutout
    translate([-20,108,0]) { chamfercyl(70,tilt_angle+8,3,3, $fn=100); }
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
