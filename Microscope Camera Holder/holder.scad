/* Microscope Camera Holder, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module holder(hole_dia, hole_offset, length, width, thickness) {
	difference() {
		union() {
			// Lower plate
			translate([-length / 2, -width / 2, thickness / 2]) {
				scale(v = [0.815, 0.85, 1])
					linear_extrude(height = thickness, center = true, convexity = 10)
						import(file = "holder.dxf", layer = "Outline");
			}

			// Upper plate
			translate([-length / 2 - 0.3, -width / 2 - 0.3, thickness / 2 + 0.5]) {
				scale(v = [0.825, 0.87, 1])
					linear_extrude(height = thickness - 1, center = true, convexity = 10)
						import(file = "holder.dxf", layer = "Outline");
			}

			// Guide for debugging
			*translate([0, -0.3, 0]) {
				%cube([69.1, 28.3, 5], center = true);
			}

			// Pipe
			translate([length / 2 - hole_offset, 0, 1]) {
				cylinder(h = thickness * 3, r = (hole_dia + 6) / 2);
			}
		}

		// Microscope hole
		translate([length / 2 - hole_offset, 0, -thickness]) {
			cylinder(h = thickness * 5, r1 = hole_dia / 2, r2 = hole_dia / 2 + 1);
		}
	}
}

holder(26, 17.5, 69, 29, 5);