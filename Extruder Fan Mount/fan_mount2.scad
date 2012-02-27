/* 40x40 mm fan mount, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module fan_mount(panel_thickness) {
	fan_dia = 40;
	screw_dia = 4;
	nut_dia = 5.5;
	nut_thickness = 2.5;

	module nuttrap(nutsize, length) {
		cylinder(r = nutsize / cos(180 / 6) / 2 + 0.05, length, $fn=6);
	}

	union() {
		difference() {
			union() {
				// Outer frame
				hull() {
					for (i = [1, -1]) {
						for (j = [1, -1]) {
							translate([i * fan_dia / 2 - i * fan_dia / 10,
									   j * fan_dia / 2 - j * fan_dia / 10, 0]) {
								rotate([0, 0, 90]) {
									cylinder(r = fan_dia / 10, panel_thickness);
								}
							}
						}
					}
				}

				// Nut trap outlines
				for (i = [1, -1]) {
					for (j = [1, -1]) {
						translate([i * fan_dia / 2 - i * screw_dia,
								   j * fan_dia / 2 - j * screw_dia, 0]) {
							rotate([0, 0, 90]) {
								cylinder(r = screw_dia, panel_thickness + nut_thickness);
							}
						}
					}
				}

				// Mounting bracket
				//22 mm apart
			}

			// Screw holes
			for (i = [1, -1]) {
				for (j = [1, -1]) {
					translate([i * fan_dia / 2 - i * screw_dia,
							   j * fan_dia / 2 - j * screw_dia,
							 -panel_thickness]) {
						rotate([0, 0, 90]) {
							cylinder(r = screw_dia / 2, panel_thickness * 2 + nut_thickness * 2);
						}
					}
				}
			}

			// Nut traps
			for (i = [1, -1]) {
				for (j = [1, -1]) {
					translate([i * fan_dia / 2 - i * screw_dia,
							   j * fan_dia / 2 - j * screw_dia,
							   panel_thickness]) {
						rotate([0, 0, i * j * 15]) {
							nuttrap(nut_dia, nut_thickness * 2);
						}
					}
				}
			}
	
			// Fan hole
			translate([0, 0, -panel_thickness]) {
				cylinder(r = fan_dia / 2 - panel_thickness, h = panel_thickness * 3);
			}
		}

		// Funnel
		difference() {
			cylinder(r1 = fan_dia / 2, r2 = 15, h = 40);
			translate([0, 0, -0.5]) {
				cylinder(r1 = fan_dia / 2 - panel_thickness, r2 = 15 - panel_thickness, h = 41);
			}
		}
	}
}

fan_mount(2);
