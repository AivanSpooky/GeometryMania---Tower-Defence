/// @description Insert description here
// You can write your code in this editor
if (obj_room_info.wave_started == false && !obj_room_info.placing_tower) {
	obj_room_info.coins += round(obj_wave_btn.time_left/2)
	obj_wave_btn.time_left = 0
	obj_wave_btn.next_wave_healthbar = false
	mouse_clicked = true
	obj_room_info.wave_start()
}

