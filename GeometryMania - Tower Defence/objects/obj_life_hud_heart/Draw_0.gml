/// @description Insert description here
// You can write your code in this editor

draw_self()
draw_set_font(fnt_cas)
draw_text_transformed_color(x-sprite_width/3, y-sprite_height/5, string(obj_room_info.lvl_health)+"/"+string(obj_room_info.max_health), 2, 2, 0, c_lime, c_lime, c_white, c_white, 1)
