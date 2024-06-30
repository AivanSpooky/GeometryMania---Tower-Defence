/// @description Insert description here
// You can write your code in this editor
image_alpha = 0.3
image_speed = 0
lucky = irandom_range(1, 1000)
if (lucky == 1) {
	image_index = 3
} else if (lucky > 1 and lucky < 4) {
	image_index = 2
} else if (lucky >= 4 and lucky < 12) {
	image_index = 1	
} else if (lucky >= 12 and lucky < 20) {
	image_index = 0	
}

seq = noone
if (lucky < 20) {
	seq = layer_sequence_create("PauseHallutinations", random_range(250, room_width-250), random_range(100, room_height-100), seq_hallutinations)
	seq_inst = layer_sequence_get_instance(seq)
	sequence_instance_override_object(seq_inst, obj_hallutinations, self)
} else {
	image_alpha = 0
}

self_destruct = time_source_create(time_source_game, 10, time_source_units_seconds, function() {
	instance_destroy(self)	
}, [], 1)
time_source_start(self_destruct)
