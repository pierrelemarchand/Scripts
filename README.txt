Most scripts are just tools, not to be used by themselves.
Scripts that are not tools (calling the tools) are: envelope_generator.bash ; radiance_iteration.bash

Tools :
	OF_gen.bash
		Generates a elementary part of TC Panel: just one square with a disc emitting light at its center.
	TCP_gen.bash
		Generates a TC panel.
	wall_gen.bash
		Generates a wall
	light_mat_gen.bash
		Generates the material of a light emitting surface
	wall_mat_gen.bash
		Generates the material of a wall
	up_picture.bash
		Generates a picture of the envelope, looking up
	illuminance_point_calculator.bash
		Calculates the horizontal illuminance at a precise point
	illuminance_grid_calculator.bash
		Calculates the horizontal illuminance for all points of a grid, and generates a false color plot
	daylight_autonomy.bash
		Calculates the daylight autonomy for all points of a grid, and generates a false color plot