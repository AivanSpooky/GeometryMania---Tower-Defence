/// @description Insert description here
// You can write your code in this editor

var _pos = animcurve_channel_evaluate(curve, percent)
var _start = start_y
var _end = start_y * -1
var _dist = _end - _start

if (obj_room_info.END and (obj_room_info.FAIL || obj_room_info.WIN) and abs(percent) < 1) {
	percent += 1/40
	y = _start + (_dist * _pos)
} else if (!obj_room_info.END and abs(percent) > 0) {
	percent -= 1/40
	y = _start + (_dist * _pos)
}
