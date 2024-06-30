/// @description Insert description here
// You can write your code in this editor
in_pause = false
timer = current_time
_seq_elem = noone
image_speed = 0
lucky = random_range(1, 150)
image_index = 0
if (lucky == 1) {
	image_index = 1	
}
curve = animcurve_get_channel(ac_pause_menu_appear, "curve1")
percent = 0
start_y = -300
x = 300

