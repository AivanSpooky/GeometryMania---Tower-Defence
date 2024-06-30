/// @description Insert description here
// You can write your code in this editor

function pause_event() {
	if (can_click) {
	if (in_pause) {
		in_pause = false
		can_click = false
		alarm[0] = 0.5 * 60
		if (layer_sequence_exists("PauseEndMenus", _seq_elem)) {
			layer_sequence_destroy(_seq_elem)
		}
		instance_activate_layer("Hud")
		instance_activate_layer("BuyMenuItems")
		instance_activate_layer("Weapons")
		instance_activate_layer("Instances")
		obj_buy_menu_btn.pressed = false
		obj_room_info.delete_dark_seq()
		
	} else if (!in_pause) {
		in_pause = true
		can_click = false
		alarm[0] = 0.5 * 60
		instance_deactivate_layer("Hud")
		instance_deactivate_layer("Instances")
		instance_deactivate_layer("Weapons")
		instance_deactivate_layer("BuyMenuItems")
		_seq_elem = layer_sequence_create("PauseEndMenus", 300, 420, seq_destr_pause)
		
	}
	}
 }
in_pause = false
pause_surface = -1
_seq_elem = noone
image_speed = 0
can_click = true
can_click_options = true

curve = animcurve_get_channel(ac_hide_hud, "curve1")
percent = 0
start_y = y

function hide_or_show() {
	var _pos = animcurve_channel_evaluate(curve, percent)
	var _start = start_y
	var _end = -70
	var _dist = _end - _start

	if (obj_hide_btn.hidden and abs(percent) < 1) {
		percent += 1/40
		y = _start+(_dist * _pos)
	} else if (obj_hide_btn.hidden == false and abs(percent) > 0) {
		percent -= 1/40
		y = _start+(_dist * _pos)
	}

}