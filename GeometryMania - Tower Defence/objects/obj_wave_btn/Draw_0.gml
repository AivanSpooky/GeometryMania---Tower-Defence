/// @description Insert description here
// You can write your code in this editor
draw_self()
draw_set_font(fnt_cas_2)
draw_text_transformed_color(x+sprite_width/4, y+sprite_height/2+3, string(obj_room_info.lvl_waves)+"/"+string(obj_room_info.max_waves), 2, 2, 0, c_red, c_red, c_white, c_white, 1)

var _time_ratio = (time_left/15)*100
if (next_wave_healthbar) {
	draw_text_transformed_color(x+sprite_width, y-sprite_height/2, "next wave", 2, 2, 0, c_red, c_red, c_white, c_white, 1)
	draw_healthbar(x+3*sprite_width, y-15, x+4*sprite_width, y-30, _time_ratio, c_black, c_red, c_lime, 0, true, true)	
	time_left -= 1/60
}

