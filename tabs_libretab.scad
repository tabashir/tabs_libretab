
// Which parts to build
base_plate=false;
fixed_thumb_plate=false;
bolt_on_thumb_plate=false;
palm_plate=false;
palm_ball=false;
round_palm_plate=false;
wedge_palm_plate=false;
tulip_chin_plate=false;
grooved_tulip_chin_plate=false;
tulip_full_plate=false;
jezr_plate=false;
jezc_plate=true;
jezr_palm_plate=false;
pinky_trigger=false;
spacer_ring=true;
//
// Global Sizing Variables
thickness=4;
three_finger_width=65;
bolt_slot_width=4.5;
bolt_head_width=10;

// Part Specific Variables
fixed_thumb_plate_y_pos=three_finger_width*0.76;

botp_length=25;
botp_depth=18;
botp_height_mod=0.38;
botp_height=three_finger_width*botp_height_mod;

palm_plate_length_mod=1.8;
palm_plate_depth=14;

palm_ball_depth=5;

jezr_palm_plate_depth=5;

depth=three_finger_width*0.6;
slot_depth=thickness+4;
z_slot_offset=2;
tilted_slot_gap=8.6;
tilted_slot_count=three_finger_width*0.8 / tilted_slot_gap;
tilted_slot_angle=15;
tilted_slot_length=9;

elastic_slot_width=2;

if (base_plate) {
  base_plate(false);
}

if (fixed_thumb_plate) {
  // This plate is attached to the base plate
  fixed_thumb_plate(0, fixed_thumb_plate_y_pos, 1, 1);
}

if (palm_plate) {
  x_size = three_finger_width*0.25;
  translate([0, 80, 0]) palm_plate(x_size, palm_plate_length_mod, palm_plate_depth);
}

if (palm_ball) {
  x_size = three_finger_width*0.25;
  translate([-40, 40, 0]) palm_ball(x_size, palm_plate_length_mod, palm_ball_depth);
}

if (bolt_on_thumb_plate) {
  translate([60, -150, 0]) bolt_on_thumb_plate(botp_length, botp_depth, botp_height);
}

if (round_palm_plate) {
  translate([-120, 40, 0]) rotate([180, 0, 0]) round_palm_plate();
}

if (wedge_palm_plate) {
  translate([-80, 60, 0]) rotate([180, 0, 0]) wedge_palm_plate();
}

if (jezr_palm_plate) {
  translate([70, 0, -10]) jezr_palm_plate();
}

if (tulip_chin_plate) {
  // last param is whether to include a second fillet on outside of the base plate
  // stronger, but doesn't butt up well against edge of main base plate if used
  translate([90, -70, 5]) tulip_chin_plate(1, 38, 30, 2, false);
}

if (grooved_tulip_chin_plate) {
  translate([30, -60, 10]) {
    grooved_tulip_chin_plate(plate_offset=6, length=38, width=30, height=2, angle=-9, groove_radius=13, second_fillet=true);
  }
}

if (tulip_full_plate) {
  translate([10, 80, 5]) tulip_full_plate();
}

if (jezr_plate) {
  translate([70, 0, 0]) jezr_plate();
}

if (jezc_plate) {
  translate([140, 0, 0]) jezc_plate();
}


if (pinky_trigger) {
  translate([-40, -60, 0]) pinky_trigger();
}

// Modules below

module jezr_plate() {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    ww_base_plate(scaling);

    // spacer slot
    angled_slot(92, 100, 0, 8, scaling=scaling);

    // chin or thumb rest slots
    slot_y_offset=48*scaling;
    for (slotno=[1:1:4]) {
      angled_slot(62*scaling, (tilted_slot_gap*slotno)+slot_y_offset, slot_length=8);
    }

    // pinky mount slot
    angled_slot(50, 42, -31, 25, scaling=scaling);
    angled_slot(92, 17, -6, 8, scaling=scaling);

    // elastic slots
    elastic_slot(92, 136, scaling=scaling);
    elastic_slot(92, 84, scaling=scaling);
    elastic_slot(92, 78, scaling=scaling);
    elastic_slot(92, 72, scaling=scaling);
    elastic_slot(92, 66, scaling=scaling);
    elastic_slot(92, 60, scaling=scaling);
    elastic_slot(92, 54, scaling=scaling);
    elastic_slot(92, 48, scaling=scaling);
    elastic_slot(92, 42, scaling=scaling);

    // extra slots for ring mount
    slot_y_offset2=39*scaling;
    for (slotno=[1:1:3]) {
      angled_slot(41*scaling, (tilted_slot_gap*slotno)+slot_y_offset2);
    }
    slot_y_offset3=45*scaling;
    for (slotno=[1:1:2]) {
      angled_slot(20*scaling, (tilted_slot_gap*slotno)+slot_y_offset3);
    }

    // bolt holes to secure tab
    translate([106*scaling, 30*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
    translate([106*scaling, 127*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
  }
}

module ww_base_plate(scaling) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = thickness) {
      translate([66, 72, 0]) {
        polygon([
        // top index finger front
        [58,64], [58,42],
        // nock cutout
        [51,32],[51,18],
        // middle and ring finger front
        [64,9],[64,-48],
        // bottom front curve
        [62,-55],[59,-61],[54,-66],[50,-69],[45,-71],[38,-72],[31,-72],[20,-68],[7,-61],
        // rear bottom join
        [-7,-52],[-25,-41],[-44,-28],
        // rear curve
        [-58,-18],[-61,-13],[-62,-7],[-62,0],[-61,4],[-58,9],
        // top lifeline curve
        [-54,14],[-52,15],[-48,18],[-37,25],[-23,38],[-14,52],[-3,60],
        // top curve
        [9,66],[23,70],[38,72],
        // top front join curve
        [51,72],[55,70],[56,69],[58,67]
        ]);
      }
    }
  }
}

module jezc_plate() {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    jc_base_plate(scaling);
    // spacer slot
    angled_slot(92, 100, 0, 8, scaling=scaling);

    // chin or thumb rest slots
    slot_y_offset=38*scaling;
    for (slotno=[1:1:4]) {
      angled_slot(57*scaling, (tilted_slot_gap*slotno)+slot_y_offset, slot_length=11);
    }

    // pinky mount slot
    angled_slot(58, 37, -31, 20, scaling=scaling);
    angled_slot(92, 17, -6, 8, scaling=scaling);

    // elastic slots
    elastic_slot(90, 132, scaling=scaling);
    elastic_slot(92, 84, scaling=scaling);
    elastic_slot(92, 78, scaling=scaling);
    elastic_slot(92, 72, scaling=scaling);
    elastic_slot(92, 66, scaling=scaling);
    elastic_slot(92, 60, scaling=scaling);
    elastic_slot(92, 54, scaling=scaling);
    elastic_slot(92, 48, scaling=scaling);
    elastic_slot(92, 42, scaling=scaling);

    // bolt holes to secure tab
    translate([100*scaling, 30*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
    translate([100*scaling, 122*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
  }
}

module jc_base_plate(scaling) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = thickness) {
      translate([66, 72, 0]) {
        polygon([
        // top index finger front
        [58,54], [58,42],
        // nock cutout
        [51,32],[51,18],
        // middle and ring finger front
        [64,2],[64,-48],
        // bottom front curve
        [62,-55],[59,-61],[54,-66],[50,-69],[45,-71],[38,-72],[31,-72],[20,-68],[7,-61],
        // rear bottom join
        [-7,-52],[-20,-40],[-24,-34],
        // rear
        [-25,-30],[-25,24],
        // rear top join
        [-25,24],[-23,32],
        // top lifeline curve
        [-21,37],[-17,47],[-5,59],
        // top curve
        [9,65],[23,67],[38,67],[48,67],
        // top front join curve
        [54,65],[57,61],[58,57]
        ]);
      }
    }
  }
}

module jezr_palm_plate() {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    jezr_palm_plate_base(scaling, jezr_palm_plate_depth);

    // extra slots for ring mount
    slot_y_offset2=39*scaling;
    for (slotno=[1:1:3]) {
      angled_slot(41*scaling, (tilted_slot_gap*slotno)+slot_y_offset2, thickness=jezr_palm_plate_depth);
    }
    slot_y_offset3=45*scaling;
    for (slotno=[1:1:2]) {
      angled_slot(20*scaling, (tilted_slot_gap*slotno)+slot_y_offset3, thickness=jezr_palm_plate_depth);
    }
  }
}

module jezr_palm_plate_base(scaling, thickness) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = thickness) {
      translate([66, 72, 0]) {
        polygon([
        // rear bottom join
        [-7,-16],[-32,-36],[-44,-28],
        // rear curve
        [-58,-18],[-61,-13],[-62,-7],[-62,0],[-61,4],[-58,9],
        // top lifeline curve
        [-54,14],[-52,15],[-48,18],[-37,25],[-23,38],[-10,32]
        ]);
      }
    }
  }
}

module pinky_trigger(desired_height=35) {
    // polygon is 84 high
    scaling=desired_height/84;
    difference() {
      linear_extrude(height = thickness) {
        scale([scaling*1.2, scaling, 1]) {
          translate([20, 40, 0]) {
            polygon([
              [-9,43],[12,43],[18,40],[21,37],[22,32],[22,28],
              [19,24],[15,21],[11,19],[6,15],[4,10],[3,5],[4,-3],
              [6,-9],[9,-15],[13,-21],[15,-26],[15,-31],[12,-36],
              [9,-38],[4,-40],[1,-40],[-4,-37],[-10,-27],[-14,-16],[-18,0],
              [-23,16],[-25,29],[-22,38],[-14,43]
            ]);
          }
        }
      }
      translate([10*scaling, 71*scaling, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
      translate([37*scaling, 71*scaling, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
    }
}

module base_plate(square_plate=false) {
  union() {
    difference() {
      plain_base_plate(depth, three_finger_width, thickness, square_plate);
      translate([depth*0.6, three_finger_width*0.68, z_slot_offset]) {
        bar(depth/4, bolt_slot_width, slot_depth, 0);
      }
      translate([depth*0.75, 10, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
      translate([depth*0.75, three_finger_width*0.87, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
      offset_elastic_slot(4);
      offset_elastic_slot(17);
      offset_elastic_slot(21);
      offset_elastic_slot(38);
      offset_elastic_slot(three_finger_width*0.95);

      for (slot=[1:1:tilted_slot_count]) {
        if (slot <= 3) {
          tilted_slot(7, tilted_slot_gap*slot, -tilted_slot_angle);
        } else {
          tilted_slot(7, tilted_slot_gap*slot, tilted_slot_angle);
        }
      }
    }
  }
  module offset_elastic_slot(yoffset) {
    elastic_slot(depth*0.6, yoffset);
  }
}

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

module palm_ball(radius, length_mod, palm_depth) {
  difference() {
    chamfercyl(radius,palm_depth,-2,-palm_depth/2);
    slot_length=radius*0.75;
    slot_offset=-6;

    union() {
      translate([slot_offset,0,palm_ball_depth/2]) {
        bar(slot_length,bolt_slot_width,palm_ball_depth+2,0);
        translate([slot_offset+6,0,palm_ball_depth/3]) {
          bar(slot_length,bolt_head_width,palm_ball_depth/2,0);
        }
      }
    }
  }
}

module wedge_palm_plate(slot_length=12, tilt_angle=3, length=35, height=25, thickness=4 ) {
  // rotate([0, 180, 0]) {
  rotate([0, 0, 180]) {
    difference(){
      // base plate
      difference(){
        // main square block
        rotate([0,tilt_angle,0]) { 
          radiusedblock(length,height,4,3);
        }
        translate([0,0,5]) { 
            cube([length+15,height+10,12]);
        }
      }
      // slots
      translate([8,(height+tilted_slot_gap)/3,0]) { 
          union() {
            //countersink slot
            translate([0,0,-5]) { rotate([0,0,0]) { bar(slot_length,11,12,0); } }
            // full slot
            translate([0,0,0]) { rotate([0,0,0]) { bar(slot_length,5,25,0); } }
            //countersink slot
            translate([6,tilted_slot_gap,-5]) { rotate([0,0,0]) { bar(slot_length+5,11,12,0); } }
            // full slot
            translate([6,tilted_slot_gap,0]) { rotate([0,0,0]) { bar(slot_length+5,5,25,0); } }
        }
      }
      rotate([0,tilt_angle,0]) { 
        // rounded finger cutout
        translate([75,-45,0]) { chamfercyl(70,tilt_angle+8,3,3, $fn=75); }
      }
      rotate([0,tilt_angle,0]) { 
        // rounded finger cutout
        translate([-20,90,0]) { chamfercyl(70,tilt_angle+8,3,3, $fn=75); }
      }
    }
  }
}

module tulip_full_plate() {

  plate_offset=2;
  length=38;
  width=30;
  height=1.75;

  module tulip_plate() {
    intersection() {
      radiusedblock(length,width,height,height);
      translate([36,80,0]) { chamfercyl(80,height+2,-2,-2, $fn=100); }
      translate([36,-55,0]) { chamfercyl(80,height+2,-2,-2, $fn=100); }
      translate([-length/5,-length-6,0]) { rotate([0,0,45]) {
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

  union() {
    // plate
    translate([0,0,-10+plate_offset]) {
      rotate([90,0,90]) {
         tulip_plate();
      }
    }

    // base_plate
    translate([three_finger_width+height,0,0.3]) {
      rotate([0,0,90]) {
         base_plate(true);
      }
    }

  translate([0,-2,0]) {
    // plate fillet 1
    translate([2,17,1]) {
      rotate([-90,0,0]) {
         myfillet(22,5);
      }
    }

    // plate fillet 2
    translate([2,39,3.6]) {
      rotate([90,0,0]) {
         myfillet(28,5);
      }
    }
  }

  } // end main plate union

}

module chin_plate_base(length, width, height, bolt_slot_width, slot_angle=0) {
  difference() {
    roundedcube(size=[length, length, height], radius=1);
    translate([length*1.5,0,-1]) { chamfercyl(length,height+1,2,2, $fn=200); }
    translate([length/3.5,7,0]) { rotate([0, 0, 90-slot_angle]) { bar(length/2,bolt_slot_width,12,0); }
    }
  }
}

module tulip_chin_plate( plate_offset=2, length=38, width=30, height=2, second_fillet=true) {
  module tulip_plate() {
    intersection() {
      radiusedblock(length,width,height,height);
      translate([36,80,0]) { chamfercyl(80,height+2,-2,-2, $fn=200); }
      translate([36,-55,0]) { chamfercyl(80,height+2,-2,-2, $fn=200); }
      translate([-length/5,-length-6,0]) { rotate([0,0,45]) {
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

  union() {
    // plate
    translate([0,-0.5,-10+plate_offset]) {
      rotate([90,0,90]) {
         tulip_plate();
      }
    }

    // base_plate
    translate([length+height,0,0]) {
      rotate([0,0,90]) {
         chin_plate_base(length, width, 3, bolt_slot_width);
      }
    }

  translate([0,-2,0]) {
    // plate fillet 1
    if (second_fillet) {
      translate([height+1,16,1]) {
        rotate([-90,0,0]) {
           myfillet(22,5);
        }
      }
    }

    // plate fillet 2
    translate([height+1,length-2,height-1]) {
      rotate([90,0,0]) {
         myfillet(length-6,5);
      }
    }
  }

  } // end main plate union
}

module grooved_tulip_chin_plate( plate_offset=0, length=38, width=30, height=2, angle=-8, groove_radius=12, second_fillet=true) {
  $fn=100;

  module grooved_tulip_plate(angle=-8, groove_radius=12) {
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
        rotate([angle,90,0]) {
          cylinder(length+20,groove_radius,groove_radius+2, $fn=200);
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

  // modules put together
  union() {
    // chin plate
    translate([4.2,-10,20]) {
      rotate([0,-90,0]) {
        rotate([0,0,90]) {
           grooved_tulip_plate(angle, groove_radius);
        }
      }
    }

    translate([0,0,plate_offset]) {
      // base_plate
      translate([length+height-4,-9,0]) {
        rotate([0,0,90]) {
           chin_plate_base(length-5, width, 3, bolt_slot_width, slot_angle=15);
        }
      }

      translate([0,-7,10]) {
        // Thumb plate fillet 1
        translate([2.5,7,-9.2]) {
          rotate([-90,0,0]) {
             myfillet(22,4);
          }
        }

        // Thumb plate fillet 2
        translate([3.5,27,-6.9]) {
          rotate([90,0,0]) {
             myfillet(20,5);
          }
        }
      }
    } // end thumb plate and fillets
  } // end main plate union
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


module fixed_thumb_plate(x_pos, y_pos, x_scale, y_scale) {
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

module angled_slot(xpos, ypos, slot_angle=30, slot_length=5, slot_width=bolt_slot_width, scaling=1, thickness=thickness) {
  slot_depth=thickness*2;
  translate([xpos*scaling,ypos*scaling,thickness/2]) {
    rotate([0,0,slot_angle]) {
      bar(slot_length,slot_width,slot_depth,0);
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

module elastic_slot(xpos, ypos, scaling=1) {
  translate([xpos*scaling,ypos*scaling,z_slot_offset]) {
    bar(10,elastic_slot_width,slot_depth,0);
  }
}

module plain_base_plate(depth, height, thickness, square_plate) {
  intersection() {
    square_base_plate();
    if (!square_plate) {
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

  module square_base_plate() {
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

// Third Party Modules
//
// modules
module radiusedblock(xlen,ylen,zlen,radius){
  hull(){
    translate([radius,radius,radius]) sphere(r=radius);
    translate([xlen + radius , radius , radius]) sphere(r=radius);
    translate([radius , ylen + radius , radius]) sphere(r=radius);    
    translate([xlen + radius , ylen + radius , radius]) sphere(r=radius);
    translate([radius , radius , zlen + radius]) sphere(r=radius);
    translate([xlen + radius , radius , zlen + radius]) sphere(r=radius);
    translate([radius,ylen + radius,zlen + radius]) sphere(r=radius);
    translate([xlen + radius,ylen + radius,zlen + radius]) sphere(r=radius);
  }
}

module ninetyDegFillet(r,n) {
    /*
    r - fllet radius
    n - number of steps
    */
    function rad(x) = r - sqrt(pow(r,2) - pow(x - r, 2));
    s = r/n;            //step size
    eps = 0.001;        // a little overlap between slices
    for(i = [0 : s : r - s]) {
        translate([0, 0, i])
            minkowski() {
                linear_extrude(height = eps)
                    children();
                cylinder(r1 = rad(i), r2 = rad(i + s), h = s, $fn = 32);
            }
        }
}

// example_bar with round ends but no hole
// bar(9,4.5,19,0);

module cylinders(points, diameter, thickness){
    for (p=points){
        translate(p) cylinder(d=diameter, h=thickness, center=true);
    }
}

module plate(points, diameter, thickness, hole_diameter){
    difference(){
        hull() cylinders(points, diameter, thickness);
        cylinders(points, hole_diameter, thickness+1);
    }
}

module bar(length, width, thickness, hole_diameter){
    plate([[0,0,0], [length,0,0]], width, thickness, hole_diameter);
}


// chamfercyl - create a cylinder with round chamfered ends
module chamfercyl(
   r,              // cylinder radius
   h,              // cylinder height
   b=0,            // bottom chamfer radius (=0 none, >0 outside, <0 inside)
   t=0,            // top chamfer radius (=0 none, >0 outside, <0 inside)
   offset=[[0,0]], // optional offsets in X and Y to create
                   // convex hulls at slice level
   slices=10,      // number of slices used for chamfering
   eps=0.01,       // tiny overlap of slices
){
    astep=90/slices;
    hull()for(o = offset)
       translate([o[0],o[1],abs(b)-eps])cylinder(r=r,h=h-abs(b)-abs(t)+2*eps);
    if(b)for(a=[0:astep:89.999])hull()for(o = offset)
       translate([o[0],o[1],abs(b)-abs(b)*sin(a+astep)-eps])
          cylinder(r2=r+(1-cos(a))*b,r1=r+(1-cos(a+astep))*b,h=(sin(a+astep)-sin(a))*abs(b)+2*eps);
    if(t)for(a=[0:astep:89.999])hull()for(o = offset)
       translate([o[0],o[1],h-abs(t)+abs(t)*sin(a)-eps])
          cylinder(r1=r+(1-cos(a))*t,r2=r+(1-cos(a+astep))*t,h=(sin(a+astep)-sin(a))*abs(t)+2*eps);
}

// now build David's example, the cube with the chamfered hole (viewed from below to make things easy...)
// $fn=36;
// difference(){
//    translate([-12.5,-12.5,0])cube(25);
//    chamfercyl(3,25,3,3,[[-2,0],[2,0]]);
// }

// roundedcube(size=[20,20,20], radius=3);

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
  $fs = 0.01;
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}

// end third party modules






// module chamfercyl(
//    r,              // cylinder radius
//    h,              // cylinder height
//    b=0,            // bottom chamfer radius (=0 none, >0 outside, <0 inside)
//    t=0,            // top chamfer radius (=0 none, >0 outside, <0 inside)
//    offset=[[0,0]], // optional offsets in X and Y to create
//                    // convex hulls at slice level
//    slices=10,      // number of slices used for chamfering
//    eps=0.01,       // tiny overlap of slices
