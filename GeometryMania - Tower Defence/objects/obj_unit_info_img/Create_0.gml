/// @description Insert description here
// You can write your code in this editor
function change_skin(_index, _hp, _max_hp, bal_arm, mag_arm, _effect_resist) {
	image_index = _index
	hp = _hp
	max_hp = _max_hp
	ballistic_armor = bal_arm
	magic_armor = mag_arm
	effect_resist = _effect_resist
}

image_speed = 0
hp = 0
max_hp = 0
ballistic_armor = 0
magic_armor = 0
effect_resist = [false, false, false]

curve = animcurve_get_channel(ac_buy_menu_appear, "curve1")
percent = 0
start_y = y
offset = 45


