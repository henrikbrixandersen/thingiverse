/* 40x40 mm fan grill, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module fan_grill(fan_dia, thickness, screw_dia) {
	module screw(dia, length) {
		rotate([0, 0, 90]) {
			cylinder(r = dia / 2, length);
		}
	}

	module ring(outer_dia, width, height) {
		rotate([0, 0, 90]) {
			difference() {
				cylinder(r = outer_dia / 2, height);
				translate([0, 0, -height / 2])
					cylinder(r = outer_dia / 2 - width, height * 2);
			}
		}
	}

	union() {
		difference() {
			// Main plate
			//translate([0, 0, thickness / 2]) {
			//	cube([fan_dia, fan_dia, thickness], center = true);
			//}

			// Outer frame
			hull() {
				for (i = [1, -1]) {
					for (j = [1, -1]) {
						translate([i * fan_dia / 2 - i * screw_dia,
								 j * fan_dia / 2 - j * screw_dia,
								 0]) {
							screw(screw_dia * 2, thickness);
						}
					}
				}
			}
	
			// Screw holes
			for (i = [1, -1]) {
				for (j = [1, -1]) {
					translate([i * fan_dia / 2 - i * screw_dia,
							 j * fan_dia / 2 - j * screw_dia,
							 -thickness]) {
						screw(screw_dia, thickness * 3);
					}
				}
			}
	
			// Fan hole
			translate([0, 0, -thickness]) {
				cylinder(r = fan_dia / 2, h = thickness * 3);
			}
		}

		// Cross
		translate([0, 0, thickness / 2]) {
			rotate([0, 0, 45]) {
				cube([fan_dia, thickness, thickness], center = true);
				cube([thickness, fan_dia, thickness], center = true);
			}
		}

		// Rings
		for (i = [10 : 10 : fan_dia]) {
			ring(i, thickness, thickness);
		}
	}
}

fan_grill(40, 1.5, 4);