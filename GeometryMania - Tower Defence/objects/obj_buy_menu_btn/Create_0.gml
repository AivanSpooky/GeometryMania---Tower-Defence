/// @description Insert description here
// You can write your code in this editor
image_speed = 0
pressed = false

var _dot_x = 430 - 69
var _dot_y = -64
global.coords = ds_map_create()
for (i = 0; i < TOWERS_CNT; i++) {
	if (global.towers_selected[i]) {
		_dot_x += 69 
	    ds_map_add(global.coords, i, [_dot_x, _dot_y]);
	}
}

curve = animcurve_get_channel(ac_hide_hud, "curve1")
percent = 0
start_y = y

function hide_or_show() {
	var _pos = animcurve_channel_evaluate(curve, percent)
	var _start = start_y
	var _end = -100
	var _dist = _end - _start
	if (!obj_pause_btn.in_pause) {
			
	if (obj_hide_btn.hidden and abs(percent) < 1) {
		percent += 1/40
		y = _start+(_dist * _pos)
	} else if (obj_hide_btn.hidden == false and abs(percent) > 0) {
		percent -= 1/40
		y = _start+(_dist * _pos)
	}
	}
}
