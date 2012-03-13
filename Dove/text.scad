/* Text for Rohde, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module text(thickness) {
	union() {
		// Text
		translate([-20, -10, thickness / 2]) {
			scale(v = [1, 1, 1])
				linear_extrude(height = thickness, center = true, convexity = 10)
					import(file = "Text.dxf", layer = "Text");
		}
	}
}

text(5);