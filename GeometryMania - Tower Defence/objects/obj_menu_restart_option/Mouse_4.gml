/// @description Insert description here
// You can write your code in this editor
if (obj_pause_btn.can_click_options) {
	var _darken_seq = layer_sequence_create("Settings", 0, 0, seq_darken_map_full)
	layer_sequence_play(_darken_seq)
	alarm[0] = 1 * 60
	obj_pause_btn.can_click_options = false
	alarm[2] = 1*50
}

