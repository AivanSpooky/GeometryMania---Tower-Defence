/// @description Insert description here
// You can write your code in this editor

if (obj_pause_btn.in_pause && !obj_room_info.END) {
	image_alpha = 1
	if (!t_src_started) {
		t_src_started = true
		time_source_start(time_src)
	}
} else {
	image_alpha = 0
	t_src_started = false
	if (time_source_exists(time_src)) {
		time_source_stop(time_src)
		time_source_destroy(time_src)
	}
}
