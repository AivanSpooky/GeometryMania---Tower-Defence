/// @description Insert description here
// You can write your code in this editor

curve = animcurve_get_channel(ac_hide_hud, "curve1")
percent = 0
start_y = y

function hide_or_show() {
	var _pos = animcurve_channel_evaluate(curve, percent)
	var _start = start_y
	var _end = 800
	var _dist = _end - _start 

	if (obj_hide_btn.hidden and abs(percent) < 1) {
		percent += 1/40
		y = _start+(_dist * _pos)
	} else if (obj_hide_btn.hidden == false and abs(percent) > 0) {
		percent -= 1/40
		y = _start+(_dist * _pos)
	}

}
