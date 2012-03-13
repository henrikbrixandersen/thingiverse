/* Dove for Rohde, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 *
 * Black Peace Dove by Vervexca, http://en.wikipedia.org/wiki/File:Black_Peace_Dove.svg
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module dove(thickness) {
	union() {
		// Dove
		translate([-20, -20, thickness / 2]) {
			scale(v = [0.2, 0.2, 1])
				linear_extrude(height = thickness, center = true, convexity = 10)
					import(file = "Black_Peace_Dove.dxf", layer = "Dove");
		}
	}
}

dove(5);
