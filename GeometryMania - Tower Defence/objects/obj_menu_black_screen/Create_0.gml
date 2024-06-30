/// @description Insert description here
// You can write your code in this editor
image_alpha = 0	
x = 0
y = 0
t_src_started = false
time_src = time_source_create(time_source_game, 1, time_source_units_seconds, function() {
		instance_create_layer(0, 0, "PauseHallutinations", obj_hallutinations)	
	}, [], -1)

