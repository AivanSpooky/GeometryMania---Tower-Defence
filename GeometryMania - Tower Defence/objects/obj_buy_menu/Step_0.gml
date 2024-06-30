/// @description Insert description here
// You can write your code in this editor

var _pos = animcurve_channel_evaluate(curve, percent)
var _start = start_y
var _end = start_y * -1
var _dist = _end - _start

//show_debug_message(string(obj_buy_menu_btn.pressed) + " " + string(abs(percent)))
if (obj_buy_menu_btn.pressed and abs(percent) < 1) {
	percent += 1/40
	y = _start + (_dist * _pos)
} else if (obj_buy_menu_btn.pressed == false and abs(percent) > 0) {
	percent -= 1/40
	y = _start + (_dist * _pos)
}

