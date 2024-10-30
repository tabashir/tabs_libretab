include <./lib/chamfer_extrude.scad>; 
include <./lib/prism-chamfer.scad>;


/* [Global User Variables] */

// This will lay items out on plate. If you are working on one item, unset.
multiple_items=false;

thickness=4;
three_finger_width=65;
bolt_slot_width=4.5;
bolt_head_width=10;
elastic_slot_width=2;

// Initials/wording for some of the labels
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
mount_plate_thickness=4;

// view detail for preview render (you want this low to be fast)
preview_fn=16;
// view detail for final render (this should be higher for quality)
render_fn=100;



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
bop_length=20;
// bolt-on-thumb-plate thickness
bop_thickness=4;
// bolt-on-thumb-plate height proportion to main plate size
bop_height=30;
bop_slot_angle=4;
bop_slot_width=5;

/* [Fillet] */
fillet=false;
fillet_length=28;
fillet_height=10;

/* [Standard Chin/Thumb Plates] */
standard_plate=false;
half_standard_plate=false;

standard_plate_length=38;
standard_plate_width=15;
standard_plate_height=5;
standard_plate_angle=30;

/* [Tulip Chin/Thumb Plates] */
tulip_chin_plate=false;
half_tulip_chin_plate=false;

tulip_chin_plate_plate_lateral_offset=-4;
tulip_chin_plate_plate_=-4;
tulip_chin_plate_length=38;
tulip_chin_plate_width=29;
tulip_chin_plate_height=4;
tulip_chin_plate_plate_height=36;
tulip_chin_plate_slot_angle=0;


/* [Grooved Chin/Thumb Plates] */
grooved_half_chin_plate=false;
half_grooved_tulip_chin_plate=false;

/* [Grooved Chin Plate] */
grooved_tulip_chin_plate=false;
// how far from centre the mount plate is
grooved_oval_chin_plate=false;

// mounting / base plate included (if not then you need to join in the slicer)
grooved_chin_plate_mount=false;

// how far from centre the mount plate is
grooved_chin_plate_offset=-1;
// how long the plate is - likely you want the same as the tab width
grooved_chin_plate_length=38;
// how wide the plate on the top is
grooved_chin_plate_width=30;
// how thick the top plate is
grooved_chin_plate_height=6;
// the angle that the plate is to the base plate
grooved_chin_plate_angle=0;
// this tilts the groove from back->front slightly
grooved_chin_plate_tilt=0;
// top->bottom height of the mounting plate
grooved_chin_plate_plate_height=30;
// the angle of the mount plate slot from vertical
grooved_chin_plate_slot_angle=1;
// move the mount plate forward/back
grooved_chin_plate_longitudinal_offset=-5;
// move the mount plate up/down
grooved_chin_plate_vertical_offset=-1;
// radius of the cylinder used to make the groove
grooved_chin_plate_radius_mod=0.9;
// the larger this is, the less is cut off the front
grooved_chin_plate_front_cutoff_mod=7;

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

// bump slots up or down relative to the plate
slots_y_adjust=0;

// Loosely based on WW EZR plate, with slots for cinch band and holes for finger ring
jezr_plate=false;

// Smaller version of jezr for use with finger ring only
jezr_ring_plate=false;

// update to jezr_ring for use with finger ring only
jezr_ring_plate_2=false;

// wider version of jezr for use with finger ring only
jezr_ring_plate_3=false;

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

// squarer plate with rounded edges
rounded_edge_plate=false;


/* [Bolt-on Thumb Plate] */
bolt_on_thumb_plate=false;
// bolt-on-thumb-plate length
botp_length=25;
// bolt-on-thumb-plate thickness
botp_depth=18;
// bolt-on-thumb-plate height proportion to main plate size
botp_height_mod=0.38;


/* [Ring Plates] */

// Ring without finger spacer
bb_finger_ring=false;
// Ring with finger spacer
finger_ring_with_spacer=false;

// width around your middle finger
ring_finger_circumference=78;
// reduce if very small hands, too small may make the ring too weak.
ring_thickness=4;
// how wide the band is from front>back of the tab
ring_depth=15;

// Different shaped Spacer blocks
spacer_stl_file="jez_spacer_v3.stl"; // [jez_spacer_v1.stl, jez_spacer_v2.stl, jez_spacer_v3.stl, jez_spacer_v3.1.stl, cphughes_tab_spacer.stl]
// stretch the spacer from front>back
ring_spacer_length=31.9;
// stretch the spacer from top>bottom
ring_spacer_width=10.1;
// greater than 0 shifts ring and spacer forward
ring_spacer_forward_mod=2;
// too small will likely weaken the attachment to rest of tab
ring_spacer_plate_thickness=3.5;
// this allows fine tuning of how high the ring sits proud over the plate
ring_vertical_height_mod = 0.8;
  
// this allows fine tuning of how much of the ring is embedded in the spacer
ring_joint_spacer_overlap=0.1;



/* [Global Calculated Variables] */
tilted_slot_count=three_finger_width*0.8 / tilted_slot_gap;
$fn = $preview ? preview_fn : render_fn;

// Part Specific Variables
fixed_thumb_plate_y_pos=three_finger_width*0.76;
botp_height=three_finger_width*botp_height_mod;

number_of_cols = 4;
function get_translation_for_item(item_number) = [
  80 * (item_number % number_of_cols),
  80 * floor(item_number / number_of_cols),
  0 ];

function get_translation(item_number) =
  multiple_items ? get_translation_for_item(item_number) : get_translation_for_item(0);


if (palm_plate) {
  x_size = three_finger_width*0.25;
  translate(get_translation(2))
  palm_plate(x_size, palm_plate_length_mod, palm_plate_depth);
}

if (palm_washer) {
  x_size = three_finger_width*0.25;
  translate(get_translation(3))
  rotate([180, 0, 0])
  palm_washer(palm_washer_radius, palm_washer_depth);
}

if (bolt_on_thumb_plate) {
  translate(get_translation(4))
  bolt_on_thumb_plate(botp_length, botp_depth, botp_height);
}


if (round_palm_plate) {
  translate(get_translation(5)) rotate([180, 0, 0]) round_palm_plate();
}

if (wedge_palm_plate) {
  translate(get_translation(6)) rotate([180, 0, 0]) wedge_palm_plate();
}

if (jezr_palm_plate) {
  translate(get_translation(7)) jezr_palm_plate();
}

if (rounded_edge_plate) {
  translate(get_translation(38)) rounded_edge_plate();
}

if (tulip_chin_plate) {
  translate(get_translation(8)) {
    tulip_chin_plate(
      plate_offset=tulip_chin_plate_plate_lateral_offset,
      length=tulip_chin_plate_length,
      width=tulip_chin_plate_width,
      height=tulip_chin_plate_height,
      plate_height=tulip_chin_plate_height,
      slot_angle=tulip_chin_plate_slot_angle
    );
  }
}

if (half_tulip_chin_plate) {
  translate(get_translation(9)) {
    half_tulip_chin_plate(
      plate_offset=tulip_chin_plate_plate_lateral_offset,
      length=tulip_chin_plate_length,
      width=tulip_chin_plate_width,
      height=tulip_chin_plate_height,
      plate_height=tulip_chin_plate_height,
      slot_angle=tulip_chin_plate_slot_angle
    );
  }
}

if (bolt_on_plate) {
  translate(get_translation(10)) bolt_on_plate(bop_length, bop_thickness, bop_height, bop_slot_angle, bop_slot_width);
}

if (bolt_on_plate_with_fillet) {
  translate(get_translation(11)) bolt_on_plate_with_fillet(bop_length, bop_thickness, bop_height, bop_slot_angle, bop_slot_width);
}

if (fillet) {
  translate(get_translation(36)) {
    fillet(fillet_length, fillet_height) ;
  }
}

if (grooved_tulip_chin_plate) {
  translate(get_translation(13)) {
    grooved_tulip_chin_plate(
      plate_offset=grooved_chin_plate_offset,
      length=grooved_chin_plate_length,
      width=grooved_chin_plate_width,
      height=grooved_chin_plate_height,
      angle=grooved_chin_plate_angle,
      plate_height=grooved_chin_plate_plate_height,
      slot_angle=grooved_chin_plate_slot_angle,
      tilt=grooved_chin_plate_tilt,
      longitudinal_offset=grooved_chin_plate_longitudinal_offset,
      vertical_offset=grooved_chin_plate_vertical_offset
    );
  }
}

if (grooved_oval_chin_plate) {
  translate(get_translation(13)) {
    grooved_oval_chin_plate(
      plate_offset=grooved_chin_plate_offset,
      length=grooved_chin_plate_length,
      width=grooved_chin_plate_width,
      height=grooved_chin_plate_height,
      angle=grooved_chin_plate_angle,
      plate_height=grooved_chin_plate_plate_height,
      slot_angle=grooved_chin_plate_slot_angle,
      tilt=grooved_chin_plate_tilt,
      longitudinal_offset=grooved_chin_plate_longitudinal_offset,
      vertical_offset=grooved_chin_plate_vertical_offset
    );
  }
}

if (half_grooved_tulip_chin_plate) {
  translate(get_translation(14)) {
    half_grooved_tulip_chin_plate(plate_offset=13, length=38, width=25, height=2, angle=0, groove_radius=10);
  }
}

if (grooved_half_chin_plate) {
  translate(get_translation(15)) {
    grooved_half_chin_plate(length=25, width=7, height=4, groove_tilt=0, groove_radius=16);
  }
}

if (ks_base_plate) {
  translate(get_translation(30))
  ks_base_plate(ks_base_plate_square_plate);
}

if (half_standard_plate) {
  translate(get_translation(33))
  half_standard_plate( standard_plate_length, standard_plate_width, standard_plate_height, standard_plate_angle);
}


if (standard_plate) {
  translate(get_translation(34))
  standard_plate( standard_plate_length, standard_plate_width, standard_plate_height, standard_plate_angle);
}


if (tulip_full_plate) {
  translate(get_translation(16)) tulip_full_plate(
    tulip_full_plate_plate_offset,
    tulip_full_plate_length,
    tulip_full_plate_width,
    tulip_full_plate_height
  );
}

if (jezr_plate) {
  translate(get_translation(17)) jezr_plate();
}

if (jezr_ring_plate) {
  translate(get_translation(18)) jezr_ring_plate(initials, 1.1);
}

if (jezr_ring_plate_2) {
  translate(get_translation(38)) jezr_ring_plate_2(initials, 1.1);
}

if (jezr_ring_plate_3) {
  translate(get_translation(39)) jezr_ring_plate_3(initials, 1.1);
}

if (jezc_plate) {
  translate(get_translation(19)) jezc_plate();
}

if (jezc_ring_plate) {
  translate(get_translation(20)) jezc_ring_plate(initials, jezc_ring_plate_scaling);
}


if (pinky_trigger) {
  translate(get_translation(32)) pinky_trigger(pin=pinky_trigger_pin, bolt_front=pinky_trigger_bolt_front);
}

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
    ww_base_plate(scaling);
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

module jezr_ring_plate_2(initials, x_scale=1) {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    ww_base_plate_2(scaling);
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

module jezr_ring_plate_2(initials, x_scale=1) {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/144;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    ww_base_plate_2(scaling);
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

module jezr_ring_plate_3(initials, x_scale=1) {
  // Tab sketch is 96px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  pic_scale=74/96;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
    translate([0, slots_y_adjust, 0]) ww_base_plate_3(scaling);
    translate([7, -23, 0]) ring_plate_slots_3(scaling);

    // nock cutout
    translate([27, 0, -2 ]) {
      scale([1,0.7,1]) {
        nock_cutout(scaling);
      }
    }

    // Initials
      translate([-18, slots_y_adjust-29, thickness/1.5]) {
        initials_a();
      }
    // chin or thumb rest slots
    angled_slot(-18*scaling, 0*scaling, 70, 25*scaling, scaling=scaling);

    // palm pad slots
    angled_slot(-20*scaling, -20*scaling, 36, 19*scaling, scaling=scaling);
    angled_slot(-38*scaling, -32*scaling, 78, 15*scaling, scaling=scaling);
  }
}

module ring_plate_slots_3(scaling) {
    // bolt slots to secure tab
    bolt_slot_len=14;
    angled_slot(-8, 0, 0, slot_length=22, slot_width=5.5, scaling=scaling);
    angled_slot(0, 62, 0, slot_length=bolt_slot_len, slot_width=5.5, scaling=scaling);
    other_slot_len=18;
    translate([-3, 12, 0]){
      angled_slot(0, 0, 0, slot_length=other_slot_len*scaling);
      angled_slot(4, 8, 0, slot_length=other_slot_len*scaling);
      angled_slot(0, 16, 0, slot_length=other_slot_len*scaling);
      angled_slot(2, 24, 0, slot_length=other_slot_len*scaling);
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


module ww_base_plate_2(scaling) {
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

module ww_base_plate_3(scaling) {
  // translate([38, 52, 0]) {
    scale([scaling, scaling, 1]) {
      linear_extrude(height = thickness) {
        difference() {
          polygon([[38,41],[41,39],
          // cutout
          [41,24],[40,23],[39,23],[37,21],[37,5],[40,3],[44,3],[45,2],
          // end cutout

          [45,-33],[45,-35],[44,-38],[43,-39],[41,-41],[39,-42],[37,-43],[35,-44],[30,-45],[9,-45],[-1,-44],[-11,-43],[-20,-41],[-28,-38],[-33,-35],[-36,-32],[-38,-29],[-39,-27],[-40,-24],[-41,-20],[-41,-16],[-40,-12],[-38,-8],[-36,-6],[-32,-3],[-28,-1],[-25,1],[-22,5],[-21,8],[-19,13],[-17,19],[-15,24],[-13,28],[-11,31],[-9,34],[-6,37],[-3,39],[0,40],[4,41]]);
          // polygon([[25,30],[15,30],[15,29],[25,29]]);
          // polygon([[25,-28],[15,-28],[15,-29],[25,-29]]);
        }
      }
    }
  // }
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
      0angled_slot(69*scaling, (tilted_slot_gap*slotno)+slot_y_offset, slot_length=8);
    }


    // pinky mount slot
    angled_slot(79, 35, -16, 8, scaling=scaling);

  }

}

module ring_plate_slots(scaling, x_scale, left=38, top=50) {

    // decorative
    translate([left*x_scale, top*scaling, 0 ]) {
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
// overall size = 14x30;
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

  polygon_points = [
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
        [-10,48],[-8,55],[-6,59],[-4,61],
        // top curve
        [-2,62],[48,62],
        // top front join curve
        [54,59],[57,55],[58,52]
        ];

  scale([scaling, scaling, 1]) {
    translate([66, 72, 0]) {
      difference() {
        linear_extrude(height = plate_height) {
          polygon(polygon_points, convexity=2);
        }
        prism_chamfer_mask(polygon_points, start_edge=0, end_edge=len(polygon_points), height=0,
                     side=3.0, side2=2, corner_slope="deep");
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

  module chamfered_polygon() {
    difference() {
      linear_extrude(height = plate_height) {
        polygon(polygon_points, convexity=2);
      }
      prism_chamfer_mask(polygon_points, 
      start_edge=0, 
      end_edge=13,
      side=1,
      side2=0
     //  height=plate_height,
     // side=1.0,  corner_slope="medium"
     );
    }
  }

  difference() {
    z_miror = right_handed ? 0 : 1;
    scale([scaling, scaling, 1]) {

    mirror([0,0,z_miror])
      chamfered_polygon();
    }
    holes_x_offset=38+ring_spacer_forward_mod;
    // bolt holes to secure tab
    translate([holes_x_offset*scaling, 22*scaling, -slot_depth]) {
      cylinder(slot_depth*2, bolt_slot_width*0.55, bolt_slot_width*0.55);
    }
    translate([holes_x_offset*scaling, 120*scaling, -slot_depth]) {
      cylinder(slot_depth*2, bolt_slot_width*0.55, bolt_slot_width*0.55);
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

module rounded_edge_plate(plate_length=65, plate_width=45, plate_height=thickness) {
  scaling=65/plate_length;
  vert_offset = 25;
  horiz_offset = 4;
  base_mount_gap = 92;
  difference() {
    translate([plate_length/2, plate_width/2, 0]) {
      intersection() {
        union() {
        roundedcube(size=[plate_length, plate_width, plate_height], center=true, radius=1);
        translate([vert_offset/2, horiz_offset/2, 0]) roundedcube(size=[plate_length-vert_offset, plate_width+horiz_offset, plate_height], center=true, radius=1);
        }
        translate([0-plate_length/1.8, 0, 0]) rotate([0,0,-10]) roundedcube(size=[plate_length*2, plate_width*2, plate_height], center=true, radius=1);
      }
    }
    // slots for ring mount
// module angled_slot(xpos, ypos, slot_angle=30, slot_length=5, slot_width=bolt_slot_width, scaling=1, thickness=thickness) {
    // extra slots for ring mount
    slot_from_back=20;
    slot_length=12;
    slot_from_top=9;
    slot_gap=47;
    mount_slot_spacing=9;
    angled_slot(slot_from_top, slot_from_back, slot_length=slot_length, slot_angle=90, thickness=jezr_palm_plate_depth+2);
    angled_slot(slot_from_top+slot_gap, slot_from_back, slot_length=slot_length, slot_angle=90, thickness=jezr_palm_plate_depth);

    angled_slot(slot_from_top+(mount_slot_spacing*2), slot_from_back+5, slot_length=slot_length, slot_angle=90, thickness=jezr_palm_plate_depth+2);
    angled_slot(slot_from_top+(mount_slot_spacing*3), slot_from_back, slot_length=slot_length, slot_angle=90, thickness=jezr_palm_plate_depth+2);
    angled_slot(slot_from_top+(mount_slot_spacing*4), slot_from_back+5, slot_length=slot_length, slot_angle=90, thickness=jezr_palm_plate_depth+2);

    for (slot=[1:1:5]) {
      angled_slot(mount_slot_spacing*slot, 4, slot_length=8, slot_angle=110, thickness=jezr_palm_plate_depth+2);
    }

    nock_scaling=0.51;
    nock_offset=6*nock_scaling;
    translate([vert_offset+2,plate_width-nock_offset, -2 ]) {
      rotate([0,0,90]) nock_cutout(nock_scaling);
    }

    // Initials
    translate([22,18,0 ]) {
      rotate([0,0,90])
          initials_b();
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

module pinky_polygon_1() {
  polygon([
    [-9,43],[12,43],[18,40],[21,37],[22,32],[22,28],
    [19,24],[15,21],[11,19],[6,14],[4,10],[3,5],[4,-3],
    [5,-9],[7,-15],[8,-21],[9,-26],[9,-33],[7,-39],
    [5,-40],[3,-40],[0,-40],[-3,-37],[-15,-16],[-19,0],
    [-20,16],[-19,29],[-18,36],[-14,41]
  ]);
}

module pinky_polygon_2() {
  polygon([
    [-23,16],[-21,24],[-14,28],
    [-8,31],
    [-3,29],
    [2,20],
    [3,5],
    [4,-3],
    [6,-9],[9,-15],[13,-21],[15,-26],[14,-30],[12,-33],
    [9,-34],
    [7,-33],
    [0,-26],[-14,-5],[-18,3],
  ]);
}

module pinky_trigger(desired_height=35, pin=true, bolt_front=false) {
    // polygon is 84 high
    scaling=desired_height/84;
    hole_pos_a =(pinky_trigger_shape == "1") ? 40*scaling : 17*scaling;
    hole_pos_b =(pinky_trigger_shape == "1") ? 71*scaling : 59*scaling;
    hole_pos_c =(pinky_trigger_shape == "1") ? 15*scaling : 5*scaling;
    hole_pos_d =(pinky_trigger_shape == "1") ? 70*scaling : 57*scaling;
    union() {
    difference() {
      linear_extrude(height = thickness) {
        scale([scaling*1.2, scaling, 1]) {
          translate([20, 40, 0]) {
            if (pinky_trigger_shape == "1") {
              pinky_polygon_1();
            } else {
              pinky_polygon_2();
            }
          }
        }
      }
      // hole for bolt (front or rear)
      if (bolt_front) {
        translate([hole_pos_a, hole_pos_b, -z_slot_offset]) {
          cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
        }
      } else {
      translate([hole_pos_c, hole_pos_d, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
    }
    if (!pin) {
      if (bolt_front) {
      translate([hole_pos_c, hole_pos_d, -z_slot_offset]) {
          cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
        }
      } else {
        translate([hole_pos_a, hole_pos_b, -z_slot_offset]) {
        cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
      }
    }
    }
    }// end difference - following is union for pins
      if (pin) {
        handed_z_offset = right_handed ? 0 : -z_slot_offset*2 ;
        if (bolt_front) {
      translate([hole_pos_c, hole_pos_d, handed_z_offset]) {
            cylinder(slot_depth, bolt_slot_width*0.55, bolt_slot_width*0.55);
          }
        } else {
        translate([hole_pos_a, hole_pos_b, handed_z_offset]) {
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
      translate([base_length/8,0,0]) { 
        radiusedblock(base_length,base_width,base_height,base_height);
      }
      translate([36,80,0]) { chamfercyl(80,base_height+2,-2,-2, $fn=tmp_fn); }
      translate([36,-55,0]) { chamfercyl(80,base_height+2,-2,-2, $fn=tmp_fn); }
      translate([-base_length / grooved_chin_plate_front_cutoff_mod ,-base_length-6,0]) { 
        rotate([0,0,45]) {
          radiusedblock(base_length*2,(base_length*2)-3,base_height,base_height);
        }
      }
    }
  }
}

module scaled_oval_base_plate(length, width, height) {
  translate([length/2, 0, 0])
  resize([length, width, height]) {
    oval_base_plate();
  }

  module oval_base_plate() {
    base_length=80;
    base_width=60;
    base_height=20;
    rounding=8;
    round_mod=2*rounding;
    block_length=(base_length*2)-round_mod;
    block_width=(base_width*2)-round_mod;
    rotate([0,0,90])
    intersection() {
      chamfercyl(base_length,base_height,-rounding,-rounding); 
      translate([-base_length,-base_width,0]) { 
        radiusedblock(block_length,block_width,base_height-round_mod,rounding);
      }
    }
  }
}


module tulip_chin_plate( plate_offset=0, length=28, width=25, height=3, plate_height=36, slot_angle=10, plate_longitudinal_offset=0) {
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

module grooved_tulip_chin_plate( plate_offset=-3, length=28, width=30, height=4, angle=3, plate_height=38, slot_angle=8, tilt=2, longitudinal_offset=0, vertical_offset) {
  difference() {
    union() {
      // plate
      translate([0.5,2+longitudinal_offset,(width/2)-plate_offset]) {
        rotate([90,180+angle,-90-slot_angle]) {
             grooved_tulip_plate(angle, length, width, height, tilt);
        }
      }
      // base_plate
      if (grooved_chin_plate_mount) {
        translate([plate_height-(height/2)+3+vertical_offset,2,0]) {
          rotate([0,0,90-slot_angle]) {
             bolt_on_plate_with_fillet(plate_height*0.7, mount_plate_thickness, plate_height, slot_angle);
          }
        }
      }
    } // end main plate union
  } // end difference
}

module grooved_oval_chin_plate( plate_offset=-3, length=28, width=30, height=4, angle=3, plate_height=38, slot_angle=8, tilt=2, longitudinal_offset=0, vertical_offset) {
  difference() {
    union() {
      // plate
      translate([0.5,2+longitudinal_offset,(width/2)-plate_offset]) {
        rotate([90,180+angle,-90-slot_angle]) {
             grooved_oval_plate(angle, length, width, height, tilt);
        }
      }
      // base_plate
      if (grooved_chin_plate_mount) {
        translate([plate_height-(height/2)+3+vertical_offset,2,0]) {
          rotate([0,0,90-slot_angle]) {
             bolt_on_plate_with_fillet(plate_height*0.7, mount_plate_thickness, plate_height, slot_angle);
          }
        }
      }
    } // end main plate union
  } // end difference
}

module bolt_on_plate(length, thickness, height, slot_angle, slot_width=bolt_slot_width) {
    plate_edge_radius=2;
    tilted_slot_length=height*0.60;
    slot_pos_x=length/2;
    slot_pos_y=0;
    rounded_radius=(length/2);
    slot_rotation=90-slot_angle;
    union() {
      difference() {
        union() {
          roundedcube(size=[length, height, thickness], radius=plate_edge_radius);
          rotate([0, 0, slot_angle]) {
            roundedcube(size=[length, height, thickness], radius=plate_edge_radius);
          }
          translate([rounded_radius, 0, 0]) {
            chamfercyl(rounded_radius,thickness*0.98,-plate_edge_radius,-plate_edge_radius);
          }
        }
      translate([slot_pos_x,slot_pos_y,1]) {
        rotate([0,0, slot_rotation]) {
          bar(tilted_slot_length,slot_width,slot_depth,0);
        }
      }
    }
  }
}

module bolt_on_plate_with_fillet(length, thickness, height, slot_angle, slot_width=bolt_slot_width, double_fillet=false) {
  fillet_length=length*0.85;
  fillet_trans_mod = 1.5;
  fillet_trans=length-fillet_length-fillet_trans_mod;
  union() {
    bolt_on_plate(length, thickness, height, slot_angle, slot_width);
    if (right_handed) {
      translate([fillet_length*1.05,height, 0.5]) {
        rotate([90,90,-90]) {
           myfillet(fillet_length,thickness*1.5);
        }
      }
    } else {
      translate([fillet_trans, height, thickness*0.75]) {
        rotate([0,-90,180]) {
           myfillet(fillet_length,thickness*1.5);
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

module grooved_tulip_plate(angle, length, width, height, tilt) {
  groove_radius=width*grooved_chin_plate_radius_mod;
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

module grooved_oval_plate(angle, length, width, height, tilt) {
  groove_radius=width*grooved_chin_plate_radius_mod;
  y_translate=sin(tilt)-(height*0.75);
  difference() {
    scaled_oval_base_plate(length, width, height);
    translate([-1, 0, groove_radius+height+y_translate]) {
      rotate([0,90+tilt,0]) {
        cylinder(length+8,groove_radius,groove_radius);
      }
    }
  }
}

module finger_spacer_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_spacer_length, ring_spacer_width, right_handed) {
  inner_diameter=ring_finger_circumference/3.142;
  inner_radius=(inner_diameter/2);
  outer_radius=inner_radius+ring_thickness;
  fillet_translation=inner_radius+(ring_thickness/2);
  ring_rotation = right_handed ? 0 : 180;
  ring_translation = right_handed ? 1-outer_radius-ring_joint_spacer_overlap : outer_radius+ring_joint_spacer_overlap-1;
  z_move = right_handed ? 0 : ring_spacer_plate_thickness/2;

  translate([0,0,z_move]) {
    rotate([ring_rotation,0,0]) {
      // finger spacer
      resize([ring_spacer_length,ring_spacer_width,inner_diameter]) {
          import(spacer_stl_file);
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

module half_tulip_chin_plate( plate_offset=0, length=28, width=25, height=3, plate_height=36, slot_angle=10) {

  union() {
    // plate
    translate([0,-2,-10+plate_offset]) {
      rotate([90,0,90]) {
        intersection() {
          scaled_tulip_base_plate(length, width, height);
          translate([0,width/2,0]) {
            roundedcube(size = [length, width, height], center = false, radius = 1, apply_to = "all");
          }
        }
      }
    }
  }
}

module half_standard_plate( length=38, width=15, height=thickness, angle=30) {
  rads=-height;
  resize([length, width, height]) {
    intersection() {
      roundedcube(size=[length,width,height], center=false, radius=abs(rads)/2);
      rotate([0,0,-angle]) {
        roundedcube(size=[length,width+(2*(width*cos(width))),height], center=false, radius=abs(rads)/2);
      }
    }
  }
}


module standard_plate( length=38, width=20, height=thickness, angle=20) {
  rads=-height;
  resize([length, width, height]) {
    union() {
      half_standard_plate(length, width, height, angle);
      translate([0,abs(rads*0.75),0]) {
        mirror([0, 1, 0]) {
          half_standard_plate(length, width, height, angle);
        }
      }
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
        finger_spacer_ring(ring_finger_circumference, ring_thickness, ring_depth, ring_spacer_length, ring_spacer_width, right_handed);
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
        bar(70,51,plate_height,0);
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

  ring_x_offset=36+ring_spacer_forward_mod;
  ring_y_offset=100;
  z_move = right_handed ? ring_spacer_plate_thickness : -ring_spacer_plate_thickness;

  union() {
    translate([0,0,z_move])
    mirror([0,0,1]) bb_base_plate(scaling, ring_spacer_plate_thickness);

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

module tab_bb_plate(extended=true) {
  // Tab sketch is 144px high
  // Tab is 74px high
  // This is from tab with three_finger_width=65
  x_scale=1.5;
  pic_scale=65/138;
  resize_scale=three_finger_width/65;
  scaling=pic_scale*resize_scale;
  slot_spacing=2;
  slot_range=124; // 144-gap for top and bottom
  number_of_slots=slot_range/slot_spacing;
  //  angled_slot(xpos, ypos, slot_angle=30, slot_length=12, slot_width=bolt_slot_width) {
  difference() {
  scale([x_scale,1,1])
    bb_base_plate(scaling);

        // translate([66, 72, 0]) {
    // elastic slots
    for(slot = [0 : 3 : number_of_slots]) {
      long_slot = (slot % 2) == 0;
      slot_len = long_slot ? 3 : 6;
      fingernail_slot(67-(slot_len*2), 10+(slot*slot_spacing), thickness, slot_len, scaling=scaling);
    }
    translate([0,0,-4]) 
    angled_slot(23, 19, slot_angle=90, slot_length=25, slot_width=bolt_slot_width);


    initial_translation = right_handed ? thickness : -thickness;
    // Initials
    translate([12, 20, initial_translation]) {
      scale([1,1,3])
      initials_b();
    }

  }
  module fingernail_slot(xpos, ypos, thickness, slot_len, scaling=1) {
    translate([xpos*scaling*x_scale,ypos*scaling,0]) {
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
rotation = right_handed ? 180 : 0;
  rotate([0,rotation,0]) {
    linear_extrude(height = thickness*2) {
      text(initials, font = initials_font, size=7, halign="center" );
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

//==============================================================================
//
//           prism-chamfer - the missing chamfer tool for OpenSCAD
//
// Author:  Heath Raftery
// Origin:  http://github.com/hraftery/prism-chamfer
// License: GPLv3, see LICENSE for terms.
//
// See the accompanying README for instructions on use.
//
//==============================================================================


//===========
// Variables
//===========

ff=0.001; // Fudge factor: amount of extra mask to prevent zero thickness planes.


//===========
// Functions
//===========

function translate_towards(p0, p1, dist) = p0 + (dist/norm(p1-p0))*(p1-p0);
function min_index(v, only_first=false) = search(min(v), v, only_first?1:0);
function max_index(v, only_first=false) = search(max(v), v, only_first?1:0);
function mod(a,n) = (a+n)%n; // add support for (slightly) negative modulo

//Find the cartesian angle of a vector from p0 to p1.
//Note contrary to docs, atan2 returns [-180,180]
function angle_of(p0, p1) = atan2(p1.y-p0.y, p1.x-p0.x);

//Calculate angle halfway between the angles of a vertex.
//Ref: https://math.stackexchange.com/a/4750179/787256
function corner_angle(p0, p1, p2) =
  let (a0       = angle_of(p0,p1),
       a1       = angle_of(p1,p2),
       deltaA   = a1 - a0,
       inner_dA = deltaA < -180 ? deltaA + 360 :
                  deltaA >  180 ? deltaA - 360 :
                                  deltaA)
    a0 + (inner_dA/2);

//Return the three points that define the vertex at the point specified
function vertex_points(polygon_points, point_index) =
  let (num_pts = len(polygon_points))
    [ polygon_points[mod(point_index-1, num_pts)],
      polygon_points[mod(point_index  , num_pts)],
      polygon_points[mod(point_index+1, num_pts)] ];

//Determine orientation of polygon. Ref:
//  https://en.wikipedia.org/wiki/Curve_orientation#Orientation_of_a_simple_polygon
function is_polygon_orientation_clockwise(polygon_points) =
  let (min_x_indices                = min_index([for (pt = polygon_points) pt.x]),
       min_y_index_in_min_x_indices = min_index([for (i = min_x_indices) polygon_points[i].y]),
       min_x_min_y_index            = min_x_indices[min_y_index_in_min_x_indices[0]],
       vertex_pts                   = vertex_points(polygon_points, min_x_min_y_index))
    is_vertex_convex(vertex_pts, true);

function is_vertex_convex(pts, cw) =
  let (A = pts[0], B = pts[1], C = pts[2],
       //This determinate calc is the same as cross(AB,BC). But we have points,
       //so use the simplification from the polygon orientation reference above.
       det = (B.x-A.x)*(C.y-A.y) - (C.x-A.x)*(B.y-A.y),
       right_turn = det < 0)
    cw == right_turn; //right turns are convex when going cw, and vice-versa


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






// module chamfercyl(
//    r,              // cylinder radius
//    h,              // cylinder height
//    b=0,            // bottom chamfer radius (=0 none, >0 outside, <0 inside)
//    t=0,            // top chamfer radius (=0 none, >0 outside, <0 inside)
//    offset=[[0,0]], // optional offsets in X and Y to create
//                    // convex hulls at slice level
//    slices=10,      // number of slices used for chamfering
//    eps=0.01,       // tiny overlap of slices
