/// @description Insert description here
// You can write your code in this edi
draw_self()
draw_healthbar(x+3*sprite_width/2, y, x+6*sprite_width, y+sprite_height/2, (hp/max_hp)*100, c_red, c_lime, c_lime, 0, true, true)
draw_text_color(x+3.25*sprite_width, y+sprite_height/4, string(hp)+"/"+string(max_hp), c_white, c_white, c_white, c_white, 1)

if (ballistic_armor > 0) {
	draw_sprite(spr_resist_status, 1, x+sprite_width+offset, y+sprite_height/2)
	draw_text_color(x+10*sprite_width/9+offset, y+sprite_height/1.5, string(100*ballistic_armor)+"%", c_white, c_white, c_white, c_white, 1)
} else {
	draw_sprite(spr_resist_status, 0, x+sprite_width+offset, y+sprite_height/2)
}
if (magic_armor > 0) {
	draw_sprite(spr_resist_status, 2, x+sprite_width+2*offset, y+sprite_height/2)
	draw_text_color(x+10*sprite_width/9+2*offset, y+sprite_height/1.5, string(100*magic_armor)+"%", c_white, c_white, c_white, c_white, 1)
} else {
	draw_sprite(spr_resist_status, 0, x+sprite_width+2*offset, y+sprite_height/2)
}
if (effect_resist[0]) {
	draw_sprite(spr_resist_status, 3, x+sprite_width+3*offset, y+sprite_height/2)
} else {
	draw_sprite(spr_resist_status, 0, x+sprite_width+3*offset, y+sprite_height/2)
}
if (effect_resist[1]) {
	draw_sprite(spr_resist_status, 4, x+sprite_width+4*offset, y+sprite_height/2)
} else {
	draw_sprite(spr_resist_status, 0, x+sprite_width+4*offset, y+sprite_height/2)
}
if (effect_resist[2]) {
	draw_sprite(spr_resist_status, 5, x+sprite_width+5*offset, y+sprite_height/2)
} else {
	draw_sprite(spr_resist_status, 0, x+sprite_width+5*offset, y+sprite_height/2)
}