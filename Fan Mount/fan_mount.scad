/* 40x40x10 mm fan mount, http://www.thingiverse.com/thing:15663
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module fan_mount(fan_w, fan_d, wire_d, flange_size, screw_d) {
	module flange(w, h, d) {
		polyhedron(points = [[0, -d / 2, h], [0, d / 2, h], [0, d / 2, 0], 
	                        [0, -d / 2, 0], [w, -d / 2, h], [w, d / 2, h]], 
				   triangles = [[0, 3, 2], [0, 2, 1],  [3, 0, 4], [1, 2, 5],
							    [0, 5, 4], [0, 1, 5],  [5, 2, 4], [4, 2, 3]]);
	}

	module screw(len, d) {
		rotate(a = [90, 0, 0]) {
			cylinder(h = len, r = d / 2);
		}
	}

	difference() {
		union() {
			// Main cube
			translate([0, 0, fan_d / 2 + flange_size]) {
				cube(size = [fan_w, fan_d, fan_d], center = true);
			}

			// Left screw flange
			translate([- fan_w / 2, 0, 0]) {
				flange(flange_size, flange_size, fan_d / 3);
			}

			// Right screw flange
			mirror([1, 0, 0]) {
				translate([- fan_w / 2, 0, 0]) {
					flange(flange_size, flange_size, fan_d / 3);
				}
			}

			// Front side
			translate([0, fan_d / 2 + 1, fan_d / 2 - flange_size / 2 + flange_size]) {
				cube(size = [fan_w, 2, fan_d + flange_size], center = true);
			}

			// Back side
			mirror([0, 1, 0]) {
				translate([0, fan_d / 2 + 1, fan_d / 2 - flange_size / 2 + flange_size]) {
					cube(size = [fan_w, 2, fan_d + flange_size], center = true);
				}
			}

			// Wire holder
			translate([0, 0, fan_d + flange_size - 1]) {
				cylinder(h = fan_d, r = fan_d / 2);
			}
			translate([0, 0, fan_d * 2 + flange_size - 1]) {
				sphere(h = fan_d, r = fan_d / 2);
			}
		}

		// Wire hole
		cylinder(h = fan_d * 4, r = wire_d / 2);

		// Wire canal
		translate([- fan_w / 2 + flange_size + 1, 0, flange_size]) {
			rotate(a = [0, 90, 0]) {
				cylinder(h = fan_w - 2 * flange_size - 2, r = wire_d / 2);
			}
		}

		// Left screw hole
		translate([(-fan_w / 2) + flange_size / 2, fan_d, flange_size / 2]) {
			screw(fan_d * 2, screw_d);
		}

		// Right screw hole
		translate([(fan_w / 2) - flange_size / 2, fan_d, flange_size / 2]) {
			screw(fan_d * 2, screw_d);
		}

		// Fan hole
		translate([0, fan_d, -fan_w / 2 + flange_size - 1]) {
			rotate(a = [90, 0, 0]) {
				cylinder(h = fan_d * 2, r = fan_w / 2);
			}
		}
	}
}

fan_mount(40, 10, 5, 7, 4);