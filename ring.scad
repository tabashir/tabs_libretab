
inner_circumference=75;
inner_diameter=inner_circumference/3.142;
ring_thickness=4;
ring_height=15;
plate_length=70;
plate_width=30;
plate_depth=3;

spacer_length_mod=1.2;

//use to adjust if you like tight or loose fit
ring_fudge_factor=0.95;

inner_radius=(inner_diameter/2)*ring_fudge_factor;
outer_radius=inner_radius+ring_thickness;
ring_y_offset_ratio=4/7;
ring_y_offset=plate_length*ring_y_offset_ratio;

union() {
  $fn=100;
  translate([ring_y_offset,plate_width/3,outer_radius]) {
    rotate([90,0.0]) {
      resize([0,0,ring_height]) torus(outer_radius, inner_radius);
    }
  }
  translate([ring_y_offset-(outer_radius*1.1),plate_width/2.3,0]) {
    scale([1,spacer_length_mod,1]) {
      rotate([0,0,270]) {
        import("cphughes_tab_spacer.stl");
      }
    }
  }

  roundedcube(size=[plate_length,plate_width,plate_depth], radius=plate_depth/2);

}


module torus(outerRadius, innerRadius)
{
  r=(outerRadius-innerRadius)/2;
  rotate_extrude() translate([innerRadius+r,0,0]) circle(r);
}


module oval_torus(inner_radius, thickness=[0, 0])
{
  rotate_extrude() translate([inner_radius+thickness[0]/2,0,0]) ellipse(width=thickness[0], height=thickness[1]);
}

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

