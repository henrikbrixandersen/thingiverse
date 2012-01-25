/* 40x40 mm fan mount, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module fan_mount(fan_dia, screw_dia) {
	thickness = 2;

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
						translate([i * 50 / 2 - i * 4, 10, 0]) {
							cylinder(r = screw_dia, h = thickness);
						}
					}
				}
			}
		
			// Mouting holes
			for (i = [1, -1]) {
				translate([i * 50 / 2 - i * 4, 10, -thickness]) {
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

fan_mount(40, 4);
