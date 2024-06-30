/// @description Insert description here
// You can write your code in this editor
function choose_level_click() {
	if (!clicked) {
		can_click_circles = false
		clicked = true
		if (darken_seq == noone || !layer_sequence_exists("Darken", darken_seq)) {
			darken_seq = layer_sequence_create("Darken", 0, 0, seq_darken_map)
		}
	} else {
		alarm[0] = 0.5 * 60
		if (layer_sequence_exists("Darken", darken_seq)) {
			layer_sequence_destroy(darken_seq)	
		}
		clicked = false
		for (i = 0; i < instance_number(obj_choose_level); i++) {
			inst = instance_find(obj_choose_level, i)
			inst.deselect()
		}
	}
}

max_level = -1
clicked = false
can_click_circles = true
for (i = 0; i < LEVELS_CNT; i++) {
	btn = instance_find(obj_choose_level, i)
	//show_debug_message(string(i) + " " + string(btn.level))
	choose_level_buttons[btn.level, 0] = btn.x
	choose_level_buttons[btn.level, 1] = btn.y
	choose_level_buttons[btn.level, 2] = btn.state
	max_level = (max_level > btn.level) ? max_level : btn.level
}

darken_seq = noone
lighten_seq = layer_sequence_create("Black", 0, 0, seq_lighten_map_full)
//destroy_lighten = time_source_create(time_source_game, 1.1, time_source_units_seconds, [], 1)
//time_source_start(destroy_lighten)


