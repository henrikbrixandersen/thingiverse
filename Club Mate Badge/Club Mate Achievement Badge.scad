/* Club Mate Achievement Badge, part of http://www.thingiverse.com/thing:XXXXX
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
$fn = 100;

module club_mate_badge(thickness, diameter) {
	raw_diameter = 83.2556;
	scale = diameter / raw_diameter;

	echo("Scaling by: ", scale);

	union() {
		scale(v = [scale, scale, 1]) {
			translate([-raw_diameter / 2, -raw_diameter / 2, 0]) {
				difference() {
					// Base
					linear_extrude(height = thickness, center = false, convexity = 10)
						import(file = "Club Mate.dxf", layer = "Base");
	
					// Outer spikes
					translate([0, 0, thickness * 1/3]) {
						linear_extrude(height = thickness, center = false, convexity = 10)
							import(file = "Club Mate.dxf", layer = "Outer");
					}
				}
	
				// Inner figure
				linear_extrude(height = thickness, center = false, convexity = 10)
					import(file = "Club Mate.dxf", layer = "Inner");
			}
		}
	}
}

club_mate_badge(5, 50);
