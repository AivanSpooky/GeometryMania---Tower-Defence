/// @description Insert description here
// You can write your code in this editor

delta += step
image_xscale = scale + delta
image_yscale = scale + delta
if (image_xscale >= scale + 1/4) {
	step *= -1	
} else if (image_xscale <= scale) {
	step *= -1
}

if (obj_room_info.wave_started) {
	if (mouse_clicked) {
		var _before_destroy = time_source_create(time_source_game, 1, time_source_units_seconds, self.destruction, [], 1)
		time_source_start(_before_destroy)
		dissappear_seq = layer_sequence_create("Instances", x, y, seq_upcoming_wave_disappear)
		dissappear_inst = layer_sequence_get_instance(dissappear_seq)
		sequence_instance_override_object(dissappear_inst, obj_upcoming_wave, self)
		mouse_clicked = false
	} else if (flag) {
		var _before_destroy = time_source_create(time_source_game, 1, time_source_units_seconds, self.destruction, [], 1)
		time_source_start(_before_destroy)
		dissappear_seq = layer_sequence_create("Instances", x, y, seq_upcoming_wave_disappear)
		dissappear_inst = layer_sequence_get_instance(dissappear_seq)
		sequence_instance_override_object(dissappear_inst, obj_upcoming_wave, self)
		flag = false
	}
}

