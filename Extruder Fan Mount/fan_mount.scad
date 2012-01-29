/* 40x40 mm fan mount, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module fan_mount() {
	fan_dia = 40;
	screw_dia = 4;
	thickness = 2;
	bracket_width = 50;
	bracket_x_offset = -5;
	bracket_y_offset = 5;

	module screw(dia, length) {
		rotate([0, 0, 90]) {
			cylinder(r = dia / 2, length);
		}
	}

	union() {
		difference() {
			union() {
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

				// Mounting bracket
				hull() {
					for (i = [1, -1]) {
						translate([i * bracket_width / 2 - i * screw_dia + bracket_x_offset,
								 bracket_y_offset, 0]) {
							cylinder(r = screw_dia, h = thickness);
						}
					}
				}
			}
		
			// Mouting holes
			for (i = [1, -1]) {
				translate([i * bracket_width / 2 - i * screw_dia + bracket_x_offset,
						 bracket_y_offset, -thickness]) {
					cylinder(r = screw_dia / 2, h = thickness * 3);
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
				cylinder(r = fan_dia / 2 - thickness, h = thickness * 3);
			}
		}

		// Mounting rod
		translate([bracket_width / 2 - screw_dia + bracket_x_offset,
				 bracket_y_offset, 0]) {
			cylinder(r = screw_dia / 2, h = thickness * 6);
		}

		// Funnel
		difference() {
			cylinder(r1 = fan_dia / 2, r2 = 15, h = 20);
			translate([0, 0, -0.5]) {
				cylinder(r1 = fan_dia / 2 - thickness, r2 = 15 - thickness, h = 21);
			}
			translate([0, fan_dia / 4, 25]) {
				cube([fan_dia, fan_dia / 2, 50], center = true);
			}
			translate([- fan_dia, 5, 12]) {
				rotate([0, 90, 0]) {
					cylinder(r = 15, h = fan_dia * 2);
				}
			}

		}
	}
}

fan_mount();
