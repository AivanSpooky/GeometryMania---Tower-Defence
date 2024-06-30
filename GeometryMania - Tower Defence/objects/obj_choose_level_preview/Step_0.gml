/// @description Insert description here
// You can write your code in this editor

var _pos = animcurve_channel_evaluate(curve, percent)
var _start = start_y
var _end = 300
var _dist = _end - _start

if (obj_levels_path.clicked and abs(percent) < 1) {
	percent += 1/40
	y = _start + (_dist * _pos)
} else if (!obj_levels_path.clicked and abs(percent) > 0) {
	percent -= 1/40
	y = _start + (_dist * _pos)
}

image_index = global.level
