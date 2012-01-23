/* 40x40 mm fan grill, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

module fan_grill(fan_dia, thickness, grill_thickness, screw_dia) {
	module screw(dia, length) {
		rotate([0, 0, 90]) {
			cylinder(r = dia / 2, length);
		}
	}

	module ring(outer_dia, width, height) {
		rotate([0, 0, 90]) {
			difference() {
				cylinder(r = outer_dia / 2, height);
				// Use outer_dia as parameter to ensure manifoldness of concentric rings
				translate([0, 0, -outer_dia + height])
					cylinder(r = outer_dia / 2 - width, outer_dia * 2 + height);
			}
		}
	}

	module teardrop(dia, thickness) {
		union() {
			cylinder(h = thickness, r = dia / 2, center = true);
			intersection() {
				rotate(45, [0, 0, 1]) cube([dia, dia, thickness], center = true);
				translate([0, dia * 1.375, 0]) cube([dia, dia * 2, thickness],
						 center = true);
			}
		}
	}

	union() {
		difference() {
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
				cylinder(r = fan_dia / 2 - grill_thickness, h = thickness * 3);
			}
		}

		difference() {
			union() {
				// Cross
				translate([0, 0, thickness / 2]) {
					rotate([0, 0, 45]) {
						cube([fan_dia, grill_thickness, thickness], center = true);
						cube([grill_thickness, fan_dia, thickness], center = true);
					}
				}
		
				translate([0, 0, thickness / 2 + 0.25]) {
					teardrop(10, thickness + 0.5);
				}

				// Rings
				for (i = [20 : 10 : fan_dia - grill_thickness]) {
					ring(i, grill_thickness, thickness);
				}
			}

			// Text cutout
			translate([-16.5, -13, thickness]) {
				linear_extrude(height = thickness * 3, center = true, convexity = 10)
					import(file = "RepRap.dxf", layer = "Cutout");
			}
		}

		// Text
		translate([-16.5, -13, thickness / 2 + 0.25]) {
			linear_extrude(height = thickness + 0.5, center = true, convexity = 10)
				import(file = "RepRap.dxf", layer = "Text");
		}
	}
}

fan_grill(40, 2, 1.5, 4);
