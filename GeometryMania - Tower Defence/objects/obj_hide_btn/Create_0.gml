/// @description Insert description here
// You can write your code in this editor
hidden = false
image_speed = 0

function hide_btn_clicked() {
	if (hidden) {
		hidden = false
		obj_room_info.hide_hud()
	} else if (!hidden) {
		hidden = true
		obj_buy_menu_btn.pressed = false
		obj_room_info.delete_dark_seq()
		obj_room_info.hide_hud()
	}
}

