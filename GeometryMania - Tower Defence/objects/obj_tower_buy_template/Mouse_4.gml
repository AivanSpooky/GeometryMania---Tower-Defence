/// @description Insert description here
// You can write your code in this editor

if (!obj_room_info.END && !obj_room_info.placing_tower && obj_room_info.coins >= cost) {
	obj_room_info.placing_tower = true;
	obj_buy_menu_btn.pressed = false
	obj_room_info.delete_dark_seq()
	obj_room_info.hide_hud()
	obj_blue_area.show = true
	obj_red_area.show = true
	obj_green_area.show = true
	instance_create_layer(mouse_x, mouse_y, "Instances", associated_tower, {
			tower_type: tower_type,
			cost: cost
		})
}

