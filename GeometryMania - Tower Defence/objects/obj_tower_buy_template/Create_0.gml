/// @description Insert description here
// You can write your code in this editor
image_speed = 0
// PARAMS TO CHANGE
chosen = global.towers_selected[tower_name] && global.towers_unlocked[tower_name]
if (!chosen) {
	instance_destroy(self)	
} else {
	name = "Archer"
	cost = 100
	coordinates = ds_map_find_value(global.coords, tower_name)
	if (coordinates == undefined)  {
		instance_destroy(self)
	}
	x = coordinates[0]
	y = coordinates[1]
	//

	default_depth = depth - 1
	curve = animcurve_get_channel(ac_buy_menu_appear, "curve1")
	percent = 0
}