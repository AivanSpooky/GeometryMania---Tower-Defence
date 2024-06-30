/// @description Insert description here
// You can write your code in this editor
randomize()
lucky = irandom_range(1, 400)
red = true
if (lucky == 1) {
	red = false
	image_index = 19
}
curve = animcurve_get_channel(ac_pause_menu_appear, "curve1")
percent = 0
start_y = -150
x = 300

