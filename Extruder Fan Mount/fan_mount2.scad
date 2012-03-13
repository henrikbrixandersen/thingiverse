/* 40x40 mm fan mount, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module fan_mount(panel_thickness) {
	fan_dia = 40;
	screw_dia = 3;
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
						translate([i * fan_dia / 2 - i * fan_dia / 10,
								   j * fan_dia / 2 - j * fan_dia / 10, 0]) {
							rotate([0, 0, 90]) {
								cylinder(r = fan_dia / 10, panel_thickness + nut_thickness);
							}
						}
					}
				}

				// Funnel
				cylinder(r1 = fan_dia / 2, r2 = fan_dia / 2.25, h = 30);

				// Mounting bracket
				translate([12, 0, 12]) {
					rotate([0, -65, 0]) {
						difference() {
							hull() {
								union() {
									// Mickey Mouse ears
									for (i = [1, -1]) {
										translate([22, i * 11, 0]) {
											cylinder(r = screw_dia * 1.8, panel_thickness);
										}
									}
									// Bracket
									translate([8, 0, panel_thickness / 2]) {
										cube([12, 25, panel_thickness], center = true);
									}
								}
							}
							// Screw holes
							for (i = [1, -1]) {
								translate([22, i * 11, -panel_thickness]) {
									cylinder(r = screw_dia / 2, panel_thickness * 3);
								}
							}
						}
					}
				}
			}

			// Screw holes
			for (i = [1, -1]) {
				for (j = [1, -1]) {
					translate([i * fan_dia / 2 - i * fan_dia / 10,
							   j * fan_dia / 2 - j * fan_dia / 10,
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
					translate([i * fan_dia / 2 - i * fan_dia / 10,
							   j * fan_dia / 2 - j * fan_dia / 10,
							   panel_thickness]) {
						rotate([0, 0, i * j * 15]) {
							nuttrap(nut_dia, nut_thickness * 2);
						}
					}
				}
			}
	
			// Funnel cut-out
			translate([0, 0, -0.5]) {
				cylinder(r1 = fan_dia / 2 - panel_thickness, r2 = fan_dia / 2.25 - panel_thickness, h = 31);
			}

			// Funnel cut-off
			rotate([0, -65, 0]) {
				translate([fan_dia / 2 - 5, 0, fan_dia]) {
					cube([fan_dia, fan_dia, fan_dia], center = true);
				}
			}
		}


		// Bed and extruder mock-up
		%translate([38.5, 0, 43]) {
			rotate([0, -65, 0]) {
				cube([37 + 10, 10, 10], center = true);
				translate([37 / 2, 0, 37 / 2]) {
					cube([10, 10, 37 + 10], center = true);
				}
				translate([0, 0, 43]) {
					cube([100, 100, 2], center = true);
				}
			}
		}
	}
}

fan_mount(2.5);
