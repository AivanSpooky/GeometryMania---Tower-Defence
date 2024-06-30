/// @description Insert description here
// You can write your code in this editor

if (can_place == TOWER_PLACE_STATES.CAN_PLACE) {
	can_place = TOWER_PLACE_STATES.CANT_PLACE
	instance_create_layer(mouse_x, mouse_y, "Towers", tower, {
		radius:	rad
	})
	obj_room_info.coins -= cost
	instance_destroy(self)
}