/// @description Insert description here
// You can write your code in this editor
draw_self()
if (image_index == 1) {
	draw_sprite_ext(spr_level_hud, 0, x, y+sprite_height, 2, 2, 0, c_white, 1)
	draw_text_color(x-sprite_width/2, y+sprite_height/2, name, c_white, c_green, c_white, c_green, 1)
	draw_text_color(x-sprite_width/3*2, y+sprite_height/2+40, "cost: "+string(cost), c_white, c_green, c_white, c_green, 1)	
}

if (obj_room_info.coins < cost) {
	image_alpha = 0.5	
} else {
	image_alpha = 1
}