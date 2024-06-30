/// @description Insert description here
// You can write your code in this editor
if (!obj_room_info.END && !obj_room_info.placing_tower) {
	if (obj_room_info.wave_started == false and obj_room_info.lvl_waves != obj_room_info.max_waves) {
		obj_room_info.coins += round(time_left/2)
		time_left = 0
		next_wave_healthbar = false
		pressed = true
		obj_room_info.wave_start()
		image_index = 2
	}
}
