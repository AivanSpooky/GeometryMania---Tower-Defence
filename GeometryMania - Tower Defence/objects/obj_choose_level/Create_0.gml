/// @description создание объекта для перехода на уровень
// You can write your code in this editor
function deselect() {
	state = global.levels_info[self.level];
	self.image_xscale = 1
	self.image_yscale = 1	
}

state = global.levels_info[self.level]
cur_spr_index = 0

if (state != LOCKED) {
	instance_create_layer(x-20, y-20, "stars", obj_level_star, {
		level_id: level,
		star_id: 0
	})
	instance_create_layer(x, y-30, "stars", obj_level_star, {
		level_id: level,
		star_id: 1
	})
	instance_create_layer(x+20, y-20, "stars", obj_level_star, {
		level_id: level,
		star_id: 2
	})
}