/// @description Insert description here
// You can write your code in this editor
if (chosen == false) {
	instance_destroy(self)	
}

var _pos = animcurve_channel_evaluate(curve, percent)
var _start = coordinates[1]
var _end = coordinates[1] * -1
var _dist = _end - _start
if (!obj_pause_btn.in_pause) {
	if (obj_buy_menu_btn.pressed and abs(percent) < 1) {
		percent += 1/40
		y = _start + (_dist * _pos)
	} else if (obj_buy_menu_btn.pressed == false and abs(percent) > 0) {
		percent -= 1/40
		y = _start + (_dist * _pos)
	}
}
