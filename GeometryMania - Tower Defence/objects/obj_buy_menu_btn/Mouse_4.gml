/// @description Insert description here
// You can write your code in this editor
if (!obj_room_info.END && !obj_room_info.placing_tower) {
	if (pressed) {
		pressed = false
		obj_room_info.delete_dark_seq()
	} else {
		pressed = true
		obj_room_info.play_dark_seq()
	}
}