/// @description Insert description here
// You can write your code in this editor

if (!mouse_on_btn) {
	switch (obj_room_info.wave_started) {
		case false:
			if (obj_room_info.lvl_waves != obj_room_info.max_waves) {
				image_index = 0
			} else {
				image_index = 2
			}
			break
		case true:
			image_index = 2
			break
	}
}
if (obj_room_info.wave_started == false and obj_room_info.lvl_waves > 0 and next_wave_healthbar == false and obj_room_info.lvl_waves != obj_room_info.max_waves) {
	if (next_wave_healthbar == false) {
		time_left = global.level_waves_countdown[global.level][obj_room_info.lvl_waves]
	}
	next_wave_healthbar = true
}

if (next_wave_healthbar and (time_left == 0)) {
	next_wave_healthbar = false
	if (obj_room_info.wave_started == false) {
		obj_room_info.wave_start()
	}
}

	


