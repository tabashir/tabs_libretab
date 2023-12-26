
/* [Global User Variables] */
thickness=4;
three_finger_width=65;
bolt_slot_width=4.5;
bolt_head_width=10;
elastic_slot_width=2;

initials="JM";
initials_font="Arial Black";

// saves mirroring some objects in the slicer
right_handed=false;

depth=three_finger_width*0.6;
slot_depth=thickness+4;
z_slot_offset=2;
tilted_slot_gap=8.6;
tilted_slot_angle=15;
tilted_slot_length=9;

// view detail for preview render (you want this low to be fast)
preview_fn=16;
// view detail for final render (this should be higher for quality)
render_fn=100;



/* [Pinky Trigger] */
pinky_trigger=false;
// reversed puts the peg behind the bolt
pinky_trigger_bolt_front=true;
// set this to false to have two bolt holes rather than a locating pin and a hole
pinky_trigger_pin=true;

/* [Fixed Thumb Plate] */
fixed_thumb_plate=false;

/* [Bolt-on Thumb Plate] */
bolt_on_thumb_plate=false;

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

/* [Bolt-On Plate] */
// base mount plate for a chin or thumb plate to join onto
bolt_on_plate=false;
bop_length=20;
// bolt-on-thumb-plate thickness
bop_depth=4;
// bolt-on-thumb-plate height proportion to main plate size
bop_height=30;
bop_slot_angle=4;


/* [Tulip Chin Plate] */
tulip_chin_plate=false;
half_tulip_chin_plate=false;

tulip_chin_plate_plate_offset=-4;
tulip_chin_plate_length=38;
tulip_chin_plate_width=29;
tulip_chin_plate_height=4;
tulip_chin_plate_plate_height=36;
tulip_chin_plate_slot_angle=0;

/* [grooved Half Chin Plate] */
grooved_half_chin_plate=false;


/* [Grooved Tulip Chin Plate] */
grooved_tulip_chin_plate=false;
// how far from centre the mount plate is
grooved_tulip_chin_plate_offset=-6;
// how long the plate is - likely you want the same as the tab width
grooved_tulip_chin_plate_length=38;
// how wide the plate on the top is
grooved_tulip_chin_plate_width=30;
// how thick the top plate is
grooved_tulip_chin_plate_height=6;
// the angle that the plate is to the base plate
grooved_tulip_chin_plate_angle=0;
// this tilts the groove from back->front slightly
grooved_tulip_chin_plate_tilt=0;
// top->bottom height of the mounting plate
grooved_tulip_chin_plate_plate_height=30;
// the angle of the mount plate slot from vertical
grooved_tulip_chin_plate_slot_angle=4;


/* [Fillet] */
fillet=false;
fillet_length=28;
fillet_height=10;


/* [Half Chin Plate] */
half_chin_plate=false;
half_grooved_tulip_chin_plate=false;

/* [Base Plate] */
ks_base_plate=false;
// rounds off the top and bottom of the plate (slow...)
ks_base_plate_square_plate=false;


/* [Tulip Full Plate] */
tulip_full_plate=false;

// Offset of chin plate to base_plate
tulip_full_plate_plate_offset=2;
tulip_full_plate_length=38;
tulip_full_plate_width=30;
tulip_full_plate_height=1.75;


/* [Tab Plates] */

// Loosely based on WW EZR plate, with slots for cinch band and holes for finger ring
jezr_plate=false;

// Smaller version of jezr for use with finger ring only
jezr_ring_plate=false;

// jezr with rear palm plate mounting cut off, cinch band and slots
jezc_plate=false;

// above for use with finger ring only
jezc_ring_plate=false;
jezc_ring_plate_scaling=1.2;

// Barebow plate with fingernail slots for stringwalking
tab_bb_plate=false;

// Barebow plate created outside of OpenScad, has nicely chamfered edges
mins_bb_plate=false;


// plate that can be used to extend a base plate further into the palm
jezr_palm_plate=false;
jezr_palm_plate_depth=5;



/* [Bolt-on Thumb Plate] */

// bolt-on-thumb-plate length
botp_length=25;
// bolt-on-thumb-plate thickness
botp_depth=18;
// bolt-on-thumb-plate height proportion to main plate size
botp_height_mod=0.38;


/* [Ring Spacer Plate] */
finger_ring_with_spacer=false;

// spacer ring variables
// width around your middle finger
ring_finger_circumference=76;
// 1=loose, reduce to make tighter
ring_snug_factor=1;
// reduce if very small hands, too small may make the ring too weak.
ring_thickness=4;
// how wide the band is from front>back of the tab
ring_depth=15;
// Different shaped Spacer blocks
spacer_stl_file="jez_spacer_v3.stl"; // [jez_spacer_v1.stl, jez_spacer_v2.stl, jez_spacer_v3.stl, jez_spacer_v3.1.stl, cphughes_tab_spacer.stl]
// stretch the spacer from front>back
ring_spacer_length_mod=0.9;
// stretch the spacer from top>bottom
ring_spacer_width_mod=1.1;
// greater than 0 shifts ring and spacer forward
ring_spacer_forward_mod=2;
// too small will likely weaken the attachment to rest of tab
ring_spacer_plate_thickness=2.5;

/* [Barebow Ring Spacer Plate] */
bb_finger_ring=false;

/* [Global Calculated Variables] */
tilted_slot_count=three_finger_width*0.8 / tilted_slot_gap;
$fn = $preview ? preview_fn : render_fn;

// Part Specific Variables
fixed_thumb_plate_y_pos=three_finger_width*0.76;
botp_height=three_finger_width*botp_height_mod;



number_of_cols = 4;
// function get_translation_for_item(number_of_renders) = [ 60, 60, 0 ];
function get_translation_for_item(item_number) = [
  80 * (item_number % number_of_cols),
  80 * floor(item_number / number_of_cols),
  0 ];



if (palm_plate) {
  x_size = three_finger_width*0.25;
  translate(get_translation_for_item(2))
  palm_plate(x_size, palm_plate_length_mod, palm_plate_depth);
}

if (palm_washer) {
  x_size = three_finger_width*0.25;
  translate(get_translation_for_item(3))
  rotate([180, 0, 0])
  palm_washer(palm_washer_radius, palm_washer_depth);
}

if (bolt_on_thumb_plate) {
  translate(get_translation_for_item(4))
  bolt_on_thumb_plate(botp_length, botp_depth, botp_height);
}


if (round_palm_plate) {
  translate(get_translation_for_item(5)) rotate([180, 0, 0]) round_palm_plate();
}

if (wedge_palm_plate) {
  translate(get_translation_for_item(6)) rotate([180, 0, 0]) wedge_palm_plate();
}

if (jezr_palm_plate) {
  translate(get_translation_for_item(7)) jezr_palm_plate();
}

if (tulip_chin_plate) {
  translate(get_translation_for_item(8)) {
    tulip_chin_plate(
      plate_offset=tulip_chin_plate_plate_offset,
      length=tulip_chin_plate_length,
      width=tulip_chin_plate_width,
      height=tulip_chin_plate_height,
      plate_height=tulip_chin_plate_height,
      slot_angle=tulip_chin_plate_slot_angle
    );
  }
}

if (half_tulip_chin_plate) {
  translate(get_translation_for_item(9)) {
    half_tulip_chin_plate(
      plate_offset=tulip_chin_plate_plate_offset,
      length=tulip_chin_plate_length,
      width=tulip_chin_plate_width,
      height=tulip_chin_plate_height,
      plate_height=tulip_chin_plate_height,
      slot_angle=tulip_chin_plate_slot_angle
    );
  }
}

if (bolt_on_plate) {
  translate(get_translation_for_item(10)) bolt_on_plate(bop_length, bop_depth, bop_height, bop_slot_angle);
}

if (fillet) {
  translate(get_translation_for_item(11)) {
    fillet(fillet_length, fillet_height) ;
  }
}

if (half_chin_plate) {
  // last param is whether to include a second fillet on outside of the base plate
  // stronger, but doesn't butt up well against edge of main base plate if used
  translate(get_translation_for_item(12)) half_chin_plate(28, 15, 3.5);
}

if (grooved_tulip_chin_plate) {
  translate(get_translation_for_item(13)) {
    grooved_tulip_chin_plate(
      plate_offset=grooved_tulip_chin_plate_offset,
      length=grooved_tulip_chin_plate_length,
      width=grooved_tulip_chin_plate_width,
      height=grooved_tulip_chin_plate_height,
      angle=grooved_tulip_chin_plate_angle,
      plate_height=grooved_tulip_chin_plate_plate_height,
      slot_angle=grooved_tulip_chin_plate_slot_angle,
      tilt=grooved_tulip_chin_plate_tilt
    );
  }
}

if (half_grooved_tulip_chin_plate) {
  translate(get_translation_for_item(14)) {
    half_grooved_tulip_chin_plate(plate_offset=13, length=38, width=25, height=2, angle=0, groove_radius=10);
  }
}

if (grooved_half_chin_plate) {
  translate(get_translation_for_item(15)) {
    grooved_half_chin_plate(length=25, width=7, height=4, groove_tilt=0, groove_radius=16);
  }
}

if (ks_base_plate) {
  translate(get_translation_for_item(30))
  ks_base_plate(ks_base_plate_square_plate);
}

if (fixed_thumb_plate) {
  translate(get_translation_for_item(33))
  fixed_thumb_plate(0, fixed_thumb_plate_y_pos, 1, 1);
}


if (tulip_full_plate) {
  translate(get_translation_for_item(16)) tulip_full_plate(
    tulip_full_plate_plate_offset,
    tulip_full_plate_length,
    tulip_full_plate_width,
    tulip_full_plate_height
  );
}

if (jezr_plate) {
  translate(get_translation_for_item(17)) jezr_plate();
}

if (jezr_ring_plate) {
  translate(get_translation_for_item(18)) jezr_ring_plate(initials, 1.1);
}

if (jezc_plate) {
  translate(get_translation_for_item(19)) jezc_plate();
}

if (jezc_ring_plate) {
  translate(get_translation_for_item(20)) jezc_ring_plate(initials, jezc_ring_plate_scaling);
}


if (pinky_trigger) {
  translate(get_translation_for_item(32)) pinky_trigger(pin=pinky_trigger_pin, bolt_front=pinky_trigger_bolt_front);
}

if (finger_ring_with_spacer) {
 translate(get_translation_for_item(22))
 rotate([0, 180, 0])
 finger_ring_with_spacer();
}

if (tab_bb_plate) {
  translate(get_translation_for_item(23)) tab_bb_plate();
}

if (mins_bb_plate) {
  translate(get_translation_for_item(24)) mins_bb_plate();
}

if (bb_finger_ring) {
  translate(get_translation_for_item(25))
   rotate([0, 180, 0])
  bb_finger_ring();
}


// Modules below

module jezr_ring_plate(initials, x_scale=1) {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    ww_base_plate_new(scaling);
    translate([-8, 0, 0]) ring_plate_slots(scaling, x_scale);

    // Initials
    translate([35*x_scale, 50*scaling, 0 ]) {
      translate([0, 20, thickness/1.5]) {
        initials_a();
      }
    }
    // chin or thumb rest slots
    angled_slot(106*scaling, 180*scaling, 70, 15, scaling=scaling);

    // pinky mount slot
    angled_slot(45, 44, -22, 20, scaling=scaling);
    // angled_slot(85, 13, -3, 10, scaling=scaling);

    // palm pad slot
    angled_slot(18, 54, 48, 10, scaling=scaling);
  }
}

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

module ww_base_plate_new(scaling) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = thickness) {
      translate([66, 72, 0]) {
        polygon([
        // top index finger front
        [58,54], [58,40],
        // nock cutout
        // [54,40],
        [50,32],[50,18],[57,11],[63,11],
        // middle and ring finger front
        [64,7],[64,-35],
        // bottom front curve
        [62,-40],[59,-46],[54,-51],[50,-54],[45,-56],[38,-57],[31,-57],[20,-56],
        // rear bottom join
        [7,-54],[-7,-49],[-20,-45],[-42,-35],
        // rear curve
        [-56,-26],[-63,-18],[-64,-12],[-62,-5],[-61,-1],[-58,4],
        // top of rear curve
        [-50,9],[-39,13],[-32,17],
        // top lifeline curve
        [-25,26],[-18,44],[-8,60],[-4,64],[1,66],
        // top curve
        [9,67],[48,67],
        // top front join curve
        [54,64],[57,60],[58,57]
        ]);
      }
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
        [50,32],[50,18],
        // middle and ring finger front
        [64,9],[64,-48],
        // bottom front curve
        [62,-55],[59,-61],[54,-66],[50,-69],[45,-71],[38,-72],[31,-72],[20,-70],[7,-66],
        // rear bottom join
        [-7,-60],[-20,-53],[-42,-40],
        // rear curve
        [-58,-18],[-61,-13],[-62,-7],[-62,0],[-61,4],[-58,9],
        // top lifeline curve
        [-54,14],[-52,15],[-48,18],[-37,25],[-23,32],[-10,48],[3,63],
        // top curve
        [10,68],[23,72],[38,72],
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
    jc_base_plate_old(scaling);
    // spacer slot
    angled_slot(91, 100, 0, 7, scaling=scaling);

    // chin or thumb rest slots
    slot_y_offset=38*scaling;
    for (slotno=[1:1:4]) {
      angled_slot(57*scaling, (tilted_slot_gap*slotno)+slot_y_offset, slot_length=11);
    }

    // pinky mount slot
    angled_slot(58, 37, -38, 20, scaling=scaling);
    angled_slot(91, 12, -4, 8, scaling=scaling);

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

module jezc_ring_plate(initials, x_scale=1) {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    translate([ -3, 0, 0 ]) {
      scale([x_scale,1,1]) {
        jc_base_plate(scaling);
      }
    }
    // nock cutout
    translate([57.5*x_scale, 43, -2 ]) {
      scale([x_scale,1,1]) {
        nock_cutout(scaling);
      }
    }

    ring_plate_slots(scaling, x_scale);
    //
    // decorative
    translate([40*x_scale, 50*scaling, 0 ]) {
      translate([0, 20, -1]) {
        initials_a();
      }
    }
    //
    // chin or thumb rest slots
    slot_y_offset=38*scaling;
    for (slotno=[1:1:4]) {
      angled_slot(69*scaling, (tilted_slot_gap*slotno)+slot_y_offset, slot_length=8);
    }


    // pinky mount slot
    angled_slot(79, 35, -16, 8, scaling=scaling);

  }

}

module ring_plate_slots(scaling, x_scale) {

    // decorative
    translate([38*x_scale, 50*scaling, 0 ]) {
      angled_slot(4, 14, 0, slot_length=21*scaling);
      angled_slot(12, 7, 0, slot_length=21*scaling);
      angled_slot(4, 0, 0, slot_length=21*scaling);

      // translate([0, 20, -1]) {
      //   rotate([0,0,0]) {
      //     linear_extrude(height = thickness*2) {
      //       text(initials, font = initials_font, size=8 );
      //     }
      //   }
      // }
    }

    // bolt slots to secure tab
    angled_slot(96, 30, 0, 14*x_scale, scaling=scaling);
    angled_slot(96, 122, 0, 14*x_scale, scaling=scaling);
}

module nock_cutout(scaling=1, plate_height=10) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = plate_height*2) {
        polygon([
        [14,30], [8,30],
        // nock cutout
        [0,22],[0,8],[7,1],[13,1],[14,0],
        // middle and ring finger front
        [14,0],[14,0]
        ]);
      }
  }
}

module jc_base_plate(scaling, plate_height=thickness) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = plate_height) {
      translate([66, 72, 0]) {
        polygon([
        // top index finger front
        [58,54], [58,20],
        // middle and ring finger front
        [64,16],[64,5],[64,-35],
        // bottom front curve
        [62,-40],[59,-46],[54,-51],[50,-54],[45,-56],[38,-57],[31,-57],[20,-56],[7,-52],
        // rear bottom join
        [-5,-43],[-10,-34],[-11,-29],
        // rear
        [-12,-25],[-12,24],
        // rear top join
        [-11,37],
        // top lifeline curve
        [-10,40],[-9,44],[-6,51],[-1,57],
        // top curve
        [9,61],[12,62],[38,62],[48,62],
        // top front join curve
        [54,59],[57,55],[58,52]
        ]);
      }
    }
  }
}

module jc_base_plate_larger(scaling, plate_height=thickness) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = plate_height) {
      translate([66, 72, 0]) {
        polygon([
        // top index finger front
        [58,54], [58,42],
        // nock cutout
        [54,42],[48,32],[48,18],[57,9],[63,9],
        // middle and ring finger front
        [64,7],[64,-48],
        // bottom front curve
        [62,-55],[59,-61],[54,-66],[50,-69],[45,-71],[38,-72],[31,-72],[20,-71],[7,-67],
        // rear bottom join
        [-5,-58],[-10,-49],[-11,-44],
        // rear
        [-12,-30],[-12,24],
        // rear top join
        [-12,37],
        // top lifeline curve
        [-10,45],[-9,49],[-6,56],[1,68],
        // top curve
        [9,74],[12,75],[38,75],[48,75],
        // top front join curve
        [54,71],[57,67],[58,57]
        ]);
      }
    }
  }
}

module jc_base_plate_old(scaling, plate_height=thickness) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = plate_height) {
      translate([66, 72, 0]) {
        polygon([
        // top index finger front
        [58,54], [58,42],
        // nock cutout
        [49,32],[49,18],
        // middle and ring finger front
        [64,2],[64,-48],
        // bottom front curve
        [62,-55],[59,-61],[54,-66],[50,-69],[45,-71],[38,-72],[31,-72],[20,-71],[7,-67],
        // rear bottom join
        [-7,-58],[-16,-49],[-24,-34],
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

module bb_base_plate(scaling, plate_height=thickness) {

  difference() {
    scale([scaling, scaling, 1]) {
      linear_extrude(height = plate_height) {
          polygon([
          // top index finger front
          [64,127],
          // middle and ring finger front
          [64,75],[64,3],
          // bottom front curve
          [61,0],[31,1],[20,5],
          // rear bottom join
          [7,20], [0,39],
          // top rear corner
          [20,132], [22,134], [26,136],
          // top
          [48,140],[62,140],[64,138]
          ]);
      }
    }
    // bolt holes to secure tab
    translate([34*scaling, 22*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
    translate([34*scaling, 120*scaling, -z_slot_offset]) {
      cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
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

module pinky_trigger(desired_height=35, pin=true, bolt_front=false) {
    // polygon is 84 high
    scaling=desired_height/84;
    union() {
    difference() {
      linear_extrude(height = thickness) {
        scale([scaling*1.2, scaling, 1]) {
          translate([20, 40, 0]) {
            polygon([
              [-23,16],[-21,24],[-14,28],
              [-8,31],
              [-3,29],
              [2,20],
              [3,5],
              [4,-3],
              [6,-9],[9,-15],[13,-21],[15,-26],[14,-30],[12,-33],
              [9,-33],[1,-26],[-14,-5],[-18,3],
            ]);
          }
        }
      }
      if (pin) {
        if (bolt_front) {
          translate([17*scaling, 59*scaling, -z_slot_offset]) {
            cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
          }
        } else {
        translate([5*scaling, 57*scaling, -z_slot_offset]) {
          cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
        }
      }
      }
    }
      if (pin) {
        handed_z_offset = right_handed ? 0 : -z_slot_offset*2 ;
        if (bolt_front) {
          translate([5*scaling, 57*scaling, handed_z_offset]) {
            cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
          }
        } else {
        translate([17*scaling, 59*scaling, handed_z_offset]) {
          cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
        }
      }
    }
  }
}

module ks_base_plate(square_plate=false) {
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

module palm_washer(radius, palm_depth) {
  difference() {
    chamfercyl(radius,palm_depth,-palm_depth*0.75,-1);
    slot_offset_from_edge=2;
    slot_length=(radius-slot_offset_from_edge)*0.75;
    slot_offset=slot_offset_from_edge+(bolt_head_width/2)-radius;

    union() {
      translate([slot_offset,0,0]) {
        bar(slot_length,bolt_head_width,palm_washer_depth/2,0);
        bar(slot_length,bolt_slot_width,palm_washer_depth*4,0);
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

module tulip_full_plate( plate_offset=2, length=38, width=30, height=1.75 ) {

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
         ks_base_plate(true);
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
  component_width=width/2;
  slot_bottom_offset=9;
  slot_length=(width-slot_bottom_offset)/2;
  difference() {
    union() {
      roundedcube(size=[component_width, width, height], radius=1);
      translate([(component_width*(sin(slot_angle))-2),(component_width*sin(slot_angle)),0]) {
        rotate([0,0,-slot_angle]) {
          roundedcube(size=[component_width, length, height], radius=1);
        }
      }
    }

    translate([component_width/2,slot_bottom_offset,0]) { rotate([0, 0, 90-slot_angle]) { bar(slot_length,bolt_slot_width,12,0); } }

    translate([-5, length-1, -length/2]) {
        cube(size=[length, length, length]);
    }
  }
}

module scaled_tulip_base_plate(length, width, height) {
  tmp_fn=100;
  $fn=tmp_fn;
  resize([length, width, height]) {
    tulip_base_plate();
  }

  module tulip_base_plate() {
    base_length=38;
    base_width=30;
    base_height=2;
    intersection() {
      radiusedblock(base_length,base_width,base_height,base_height);
      translate([36,80,0]) { chamfercyl(80,base_height+2,-2,-2, $fn=tmp_fn); }
      translate([36,-55,0]) { chamfercyl(80,base_height+2,-2,-2, $fn=tmp_fn); }
      translate([-base_length/5,-base_length-6,0]) { rotate([0,0,45]) {
        radiusedblock(base_length*2,(base_length*2)-3,base_height,base_height);
      } }
    }
  }
}

module half_tulip_chin_plate( plate_offset=0, length=28, width=25, height=3, plate_height=36, slot_angle=10) {
  module tulip_plate(length, width, height) {
    scaled_tulip_base_plate(length, width, height);
  }

  union() {
    // plate
    translate([0,-2,-10+plate_offset]) {
      rotate([90,0,90]) {
         tulip_plate(length, width, height);
      }
    }

    // base_plate
    translate([plate_height,0,0]) {
      rotate([0,0,90]) {
         chin_plate_base(plate_height, plate_height, thickness, bolt_slot_width, slot_angle);
      }
    }

  translate([0,-5,0]) {
    // plate fillet 1
    x_mod=plate_height/2;
    translate([height-1,x_mod+12,height-2]) {
      rotate([90,0,0]) {
         myfillet(plate_height/2,6);
      }
    }
  }

  } // end main plate union
}

module tulip_chin_plate( plate_offset=0, length=28, width=25, height=3, plate_height=36, slot_angle=10) {
  module tulip_plate(length, width, height) {
    scaled_tulip_base_plate(length, width, height);
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
    translate([0,-2,-10+plate_offset]) {
      rotate([90,0,90]) {
         tulip_plate(length, width, height);
      }
    }

    // base_plate
    translate([plate_height,0,0]) {
      rotate([0,0,90]) {
         // chin_plate_base(plate_height, plate_height, thickness, bolt_slot_width, slot_angle);
      }
    }

  translate([0,-5,0]) {
    // plate fillet 1
    x_mod=plate_height/2;
    translate([height-1,x_mod+12,height-2]) {
      rotate([90,0,0]) {
         // myfillet(plate_height/2,6);
      }
    }
  }

  } // end main plate union
}

module half_chin_plate( length=28, width=20, height=3) {
  union() {
    plate_thickness=2;
    fillet_length=length-6;
    plate_radius=width/2;
    plate_scale_factor=length/plate_radius/2;
    plate_edge_radius=-height*0.5;
    left_right_offset=plate_radius*0.35;
    // base_plate
    chin_plate_base(length-2, length, plate_thickness, bolt_slot_width);

    // plate fillet 2
    translate([fillet_length,length,plate_thickness]) {
      rotate([90,0,-90]) {
         myfillet(fillet_length-1,5);
      }
    }

    // plate
    scale([1,1,2]) {
    translate([(length/2)-1, length, plate_radius/2]) {
      rotate([-90,0,0]) {
        intersection() {
          roundedcube(size=[length, plate_radius, height],1,1);
          translate([0,left_right_offset,-height/2]) {
            scale([plate_scale_factor,1,1]) { chamfercyl(plate_radius,height,-1, plate_edge_radius); }
          }
        }
      }
    }
    }

  } // end main plate union

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
}

module grooved_half_chin_plate(length=38, width=25, height=4, groove_tilt=4, groove_radius=10) {
    plate_thickness=2.5;
    plate_radius=1;
    difference() {
      union() {
        ghcp_chin_rest();
        ghcp_mount_plate();
      }
      translate([-35,width+groove_radius-5,24]) {
        rotate([groove_tilt,98,0]) {
          cylinder(length+60,groove_radius,groove_radius+2, $fn=100);
        }
      }
    }
    //chin rest
    //
    //
  module ghcp_chin_rest() {
    difference() {
      radiusedblock(length,width,height,height/2);
      // translate([-1,-1,1+height*2]) {
      //   rotate([0,90,0]) {
      //     myfillet(length*1.5, height*2);
      //   }
      // }
      // translate([-1,width+plate_thickness*2,1+height*2]) {
      //   rotate([0,0,270]) {
      //     rotate([270,0,0]) {
      //     myfillet(length*1.5, height*2);
      //     }
      //   }
      // }
      translate([-1,0,1+height*2]) {
        rotate([270,0,0]) {
          myfillet(length, height*2);
        }
      }
    }
  }

  module ghcp_mount_plate() {
    //mount plate
    plate_height=length+10;
    difference() {
      union() {
        translate([0,0,-plate_height]) {
          intersection() {
            radiusedblock(length,plate_thickness,plate_height,plate_radius);
            translate([-length*0.6,0,plate_height/2]) {
              rotate([0,25,0]) {
                radiusedblock(length,plate_thickness,plate_height*1.2,plate_radius);
              }
            }
          }
        }
        translate([1,height*0.2,height*0.5]) {
          rotate([0,90,0]) {
            myfillet(length*0.65, height*2);
          }
        }
      }
      translate([length/4,(width*0.5),-plate_height*0.55]) {
        rotate([90,0,0]) {
          rotate([0,0,64]) {
            bar(plate_height*0.45,bolt_slot_width,width,0);
          }
        }
      }
    }
  }
}


module half_grooved_tulip_chin_plate( plate_offset=0, length=38, width=30, height=2, angle=-8, groove_radius=12, second_fillet=true) {
  cutoff=-20; // higher=less cut off
  plate_height=38;
  slot_angle=8;
  tilt=2;
  difference() {
    // grooved_tulip_chin_plate(plate_offset, length, width, height, angle, groove_radius, second_fillet);
    grooved_tulip_chin_plate( plate_offset, length, width, height, angle, plate_height, slot_angle, tilt);
    translate([-width/2,-length/4,cutoff]) {
      cube([width,length+10,width]);
    }
  }
}

module grooved_tulip_chin_plate( plate_offset=-3, length=28, width=30, height=4, angle=3, plate_height=38, slot_angle=8, tilt=2) {
  plate_thickness=4;
  difference() {
    union() {
      // plate
      translate([0.5,2,(width/2)-plate_offset]) {
        rotate([90,180+angle,-90]) {
             grooved_tulip_plate(angle, length, width, height, tilt);
        }
      }
      // base_plate
      translate([plate_height-(height/2)+3,2,0]) {
        rotate([0,0,90-slot_angle]) {
           bolt_on_plate(plate_height*0.7, plate_thickness, plate_height, slot_angle=slot_angle);
      }
      }
        // plate fillet 1
        x_mod=plate_height*0.25;
        translate([-1,x_mod*3,(plate_offset+plate_thickness*2)-1]) {
          rotate([90,0,0]) {
             myfillet(plate_height*0.5,plate_thickness*1.5);
          }
        }
    } // end main plate union
    translate([plate_height/2, -plate_height/2, 0]) {
       // cube([plate_height*2, plate_height, plate_height], true);
    }
  } // end difference
}

module bolt_on_plate(length, depth, height, slot_angle=0) {
    plate_edge_radius=2;
    tilted_slot_length=height*0.70;
    slot_pos_x=length/2;
    slot_pos_y=0;
    rounded_radius=(length/2);
    slot_rotation=90-slot_angle;
    union() {
      difference() {
        union() {
          roundedcube(size=[length, height, depth], radius=plate_edge_radius);
          rotate([0, 0, slot_angle]) {
            roundedcube(size=[length, height, depth], radius=plate_edge_radius);
          }
          translate([rounded_radius, 0, 0]) {
            chamfercyl(rounded_radius,thickness,-2,-2);
          }
        }
      translate([slot_pos_x,slot_pos_y,1]) {
        rotate([0,0, slot_rotation]) {
          bar(tilted_slot_length,bolt_slot_width,slot_depth,0);
        }
      }
    }
  }
}

module bolt_on_thumb_plate(tp_length, tp_depth, tp_height) {
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

module fillet(length, side) {
  myfillet(length, side) ;
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

module grooved_tulip_plate(angle, length, width, height, tilt) {
  groove_radius=width*0.9;
  y_translate=sin(tilt)-(height*0.75);
  difference() {
    scaled_tulip_base_plate(length, width, height);
    translate([-1, width/2, groove_radius+height+y_translate]) {
      rotate([0,90+tilt,0]) {
        cylinder(length+8,groove_radius,groove_radius);
      }
    }
  }
}

module finger_spacer_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_snug_factor, ring_spacer_length_mod, ring_spacer_width_mod, right_handed) {
  inner_diameter=ring_finger_circumference/3.142;
  inner_radius=(inner_diameter/2)*ring_snug_factor;
  outer_radius=inner_radius+ring_thickness;
  ring_rotation = right_handed ? 0 : 180;
  stl_width_shimmy=1;
  ring_translation = right_handed ? 1-outer_radius-stl_width_shimmy : outer_radius+stl_width_shimmy-1;
  z_move = right_handed ? 0 : ring_spacer_plate_thickness;
  // z_move = right_handed ? ring_spacer_plate_thickness-0.5 : 0.5;

  translate([0,0,z_move]) {
    rotate([ring_rotation,0,0]) {
      // finger spacer
      scale([ring_spacer_length_mod,ring_spacer_width_mod,1]) {
          import(spacer_stl_file);
      }
      // finger ring
      // translate([ring_thickness-2,ring_translation,inner_radius+(ring_thickness/2)]) {
      x_move = ring_thickness-(ring_thickness * ring_spacer_length_mod*0.5);
      translate([x_move,ring_translation,outer_radius]) {
        rotate([90,0,90]) {
          resize([0,0,ring_depth]) torus(outer_radius, inner_radius);
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

module finger_ring_with_spacer() {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;

  $fn=100;

  ring_x_offset=92+ring_spacer_forward_mod;
  ring_y_offset=100;

  union() {
    difference() {
      ring_base_plate(scaling, ring_spacer_plate_thickness);
      // slots (not needed but uncomment if you want to see where it would be)
      // angled_slot(ring_x_offset, ring_y_offset, 0, 4, scaling=scaling);
      // slot_y_offset=38*scaling;
      // for (slotno=[1:1:4]) {
      //   angled_slot(57*scaling, (tilted_slot_gap*slotno)+slot_y_offset, slot_length=11);
      // }
      //

      translate([30*scaling, 0, -1]) {
            // cube([40*scaling,150*scaling,ring_spacer_plate_thickness+2]);
      }

      // bolt holes to secure tab
      translate([100*scaling, 30*scaling, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
      translate([100*scaling, 122*scaling, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
    }

    translate([ring_x_offset*scaling,ring_y_offset*scaling,0]) {
      rotate([0,0,0]) {
        finger_spacer_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_snug_factor, ring_spacer_length_mod, ring_spacer_width_mod, right_handed);
      }
    }
  }
}

module ring_base_plate(scaling, plate_height=thickness) {
  ring_base_plate_basic(scaling, plate_height);
  // ring_base_plate_poly(scaling, plate_height);
}

module ring_base_plate_basic(scaling, plate_height=thickness) {
  scale([scaling, scaling, 1]) {
    translate([100, 40, 1]) {
      rotate([0, 0, 90]) {
        bar(70,51,3,0);
      }
    }
  }
}

module ring_base_plate_poly(scaling, plate_height=thickness) {
  scale([scaling, scaling, 1]) {
    linear_extrude(height = plate_height) {
      translate([66, 72, 0]) {
        polygon([
        // top index finger front
        [58,54], [58,42],
        // nock cutout
        [54,42],[48,32],[48,18],[57,9],[63,9],
        // middle and ring finger front
        [64,7],[64,-35],
        // bottom front curve
        [62,-40],[59,-46],[54,-51],[50,-54],[45,-56],[38,-57],[31,-57],[20,-53],[12,-46],
        [7,-40],[7,50],
        // top curve
        [15,62],[38,66],[48,66],
        // top front join curve
        [54,62],[57,60],[58,57]
        ]);
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

  $fn=100;

  ring_x_offset=36;
  ring_y_offset=100;

  union() {
    bb_base_plate(scaling, ring_spacer_plate_thickness);

    translate([ring_x_offset*scaling,ring_y_offset*scaling,0]) {
      rotate([0,0,0]) {
        finger_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_snug_factor);
      }
    }
  }
}

module finger_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_snug_factor) {
  inner_diameter=ring_finger_circumference/3.142;
  inner_radius=(inner_diameter/2)*ring_snug_factor;
  outer_radius=inner_radius+ring_thickness;
  ring_rotation = right_handed ? 0 : 180;
  stl_width_shimmy=1;
  ring_translation = right_handed ? -outer_radius : outer_radius;
  z_move = right_handed ? 0 : ring_spacer_plate_thickness;

  translate([0,0,z_move]) {
    rotate([ring_rotation,0,0]) {
      // finger ring
      // translate([ring_thickness-2,ring_translation,inner_radius+(ring_thickness/2)]) {
      translate([0,ring_translation,outer_radius]) {
        rotate([90,0,90]) {
          resize([0,0,ring_depth]) torus(outer_radius, inner_radius);
        }
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
  slot_spacing=2;
  slot_range=124; // 144-gap for top and bottom
  number_of_slots=slot_range/slot_spacing;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    bb_base_plate(scaling);

        // translate([66, 72, 0]) {
    // elastic slots
    for(slot = [0 : 3 : number_of_slots]) {
      long_slot = (slot % 2) == 0;
      slot_len = long_slot ? 3 : 6;
      fingernail_slot(64-(slot_len*2), 10+(slot*slot_spacing), thickness, slot_len, scaling=scaling);
    }

  }
  module fingernail_slot(xpos, ypos, thickness, slot_len, scaling=1) {
    translate([xpos*scaling,ypos*scaling,0]) {
      rotate([0,5,0]) {
        bar(slot_len,1,10,0);
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

module initials_a() {
  rotate([0,0,0]) {
    linear_extrude(height = thickness*2) {
      translate([2, 9, 0]) {
        square([12,2]);
      }
      text("J", font = initials_font, size=8 );
      translate([7, 1, 0]) {
        text("M", font = initials_font, size=6 );
      }
    }
  }
}

module initials_b() {
  rotate([0,0,0]) {
    linear_extrude(height = thickness*2) {
      text(initials, font = initials_font, size=8 );
    }
  }
}


// Third Party Modules
//
// modules

module torus(outerRadius, innerRadius)
{
  r=(outerRadius-innerRadius)/2;
  rotate_extrude() translate([innerRadius+r,0,0]) circle(r);
}


module oval_torus(inner_radius, thickness=[0, 0])
{
  rotate_extrude() translate([inner_radius+thickness[0]/2,0,0]) ellipse(width=thickness[0], height=thickness[1]);
}


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
