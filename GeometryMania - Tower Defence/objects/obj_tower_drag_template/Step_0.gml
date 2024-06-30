/// @description Insert description here
// You can write your code in this editor

x = mouse_x
y = mouse_y

//if (place_meeting(x-sprite_width/2, y, obj_red_area) || place_meeting(x+sprite_width/2, y, obj_red_area)
//|| place_meeting(x, y-sprite_height/2, obj_red_area) || place_meeting(x, y+sprite_height/2, obj_red_area)
//|| place_meeting(x-sprite_width/2, y-sprite_height/2, obj_red_area) || place_meeting(x+sprite_width/2, y+sprite_height/2, obj_red_area)
//|| place_meeting(x-sprite_width/2, y+sprite_height/2, obj_red_area) || place_meeting(x+sprite_width/2, y-sprite_height/2, obj_red_area)) {
if (place_meeting(x, y, obj_red_area) || place_meeting(x, y, obj_tower_template))
{
	in_red_area = true	
} else {
	in_red_area = false
}

//if (place_meeting(x-sprite_width/2, y, obj_blue_area) || place_meeting(x+sprite_width/2, y, obj_blue_area)
//|| place_meeting(x, y-sprite_height/2, obj_blue_area) || place_meeting(x, y+sprite_height/2, obj_blue_area)
//|| place_meeting(x-sprite_width/2, y-sprite_height/2, obj_blue_area) || place_meeting(x+sprite_width/2, y+sprite_height/2, obj_blue_area)
//|| place_meeting(x-sprite_width/2, y+sprite_height/2, obj_blue_area) || place_meeting(x+sprite_width/2, y-sprite_height/2, obj_blue_area)) {
if (place_meeting(x, y, obj_blue_area))
{
	in_blue_area = true	
} else {
	in_blue_area = false		
}

if (place_meeting(x, y, obj_green_area))
{
	in_green_area = true	
} else {
	in_green_area = false
}

switch (tower_type) {
	case TOWER_TYPES.TOWER_DISTANT: {
		if (!in_red_area and !in_blue_area) {
			image_alpha = 1	
			can_place = TOWER_PLACE_STATES.CAN_PLACE
		} else {
			image_alpha = 0.2
			can_place = TOWER_PLACE_STATES.CANT_PLACE
		}
		break
	}
	case TOWER_TYPES.TOWER_MELEE: {
		if (!in_red_area and in_green_area) {
			image_alpha = 1	
			can_place = TOWER_PLACE_STATES.CAN_PLACE
		} else {
			image_alpha = 0.2
			can_place = TOWER_PLACE_STATES.CANT_PLACE
		}
		break
	}
	case TOWER_TYPES.TOWER_OUTPOST: {
		if (!in_red_area and !in_blue_area) {
			image_alpha = 1	
			can_place = TOWER_PLACE_STATES.CAN_PLACE
		} else {
			image_alpha = 0.2
			can_place = TOWER_PLACE_STATES.CANT_PLACE
		}
		break
	}
}
