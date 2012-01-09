/* Parametric Rod Clamp, http://www.thingiverse.com/thing:13087
 *
 * Copyright (c) 2011  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module clamp(rod_d, screw_d, screw_dist, rounded) {
	rod_r = rod_d / 2;
	screw_r = screw_d / 2;
	clamp_w = screw_dist + 2.5 * screw_d;
	clamp_h = screw_d * 2.5;
	clamp_d = rod_d * 1.5;

	difference() {
		// Main cube
		if (rounded) {
			union() {
				translate([0, 0, clamp_d / 2]) {
					cube(size = [clamp_w - clamp_h, clamp_h, clamp_d], center = true);
				}
				translate([-1 * screw_dist / 2, 0, 0]) {
					cylinder(h = clamp_d, r = clamp_h / 2);
				}
				translate([screw_dist / 2, 0, 0]) {
					cylinder(h = clamp_d, r = clamp_h / 2);
				}
			}
		} else {
			translate([0, 0, clamp_d / 2]) {
				cube(size = [clamp_w, clamp_h, clamp_d], center = true);
			}
		}

		// Hole for rod
		translate([0, clamp_h, rod_d]) {
			rotate([90, 0, 0]) {
				#cylinder(h = clamp_h * 2, r = rod_r);
			}
		}
		translate([0, 0, rod_d * 1.5]) {
			cube(size = [rod_d, clamp_h * 2, rod_d], center = true);
		}

		// Left screw hole
		translate([-1 * screw_dist / 2, 0, -0.5 * clamp_d]) {
			#cylinder(h = clamp_d * 2, r = screw_r);

		}

		// Right screw hole
		translate([screw_dist / 2, 0, -0.5 * clamp_d]) {
			#cylinder(h = clamp_d * 2, r = screw_r);
		}
	}
}

clamp(8, 3, 18, true);
