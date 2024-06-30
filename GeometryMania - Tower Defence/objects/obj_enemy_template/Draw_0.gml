/// @description Insert description here
// You can write your code in this editor
draw_self()

var _hp_ratio = (hp/max_hp)*100
if (state != ENEMY_STATES.DEAD) {
	draw_healthbar(x-sprite_width/2, y-sprite_height/2-7, x+sprite_width/2, y-sprite_height/2-3, _hp_ratio, c_black, c_red, c_lime, 0, true, true)
}
