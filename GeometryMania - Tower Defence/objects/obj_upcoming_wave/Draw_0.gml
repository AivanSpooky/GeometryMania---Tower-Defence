/// @description Insert description here
// You can write your code in this editor
draw_self()

draw_set_font(fnt_cas)
draw_set_color(c_white)
if (mouse_entered and obj_room_info.lvl_waves != obj_room_info.max_waves) {
	start_y = 0
	var _enemies = global.level_waves_info[global.level][obj_room_info.lvl_waves]
	var _en = ds_map_create()
	for (i = 0; i < array_length(_enemies); i++) {
		if (_enemies[i][WAVE_INFO.PATH] == cur_path) {
			if (!ds_map_exists(_en, string(ds_map_find_value(global.enemy_names, string(_enemies[i][WAVE_INFO.ENEMY_NAME]))))) {
				ds_map_add(_en, string(ds_map_find_value(global.enemy_names, string(_enemies[i][WAVE_INFO.ENEMY_NAME]))), _enemies[i][WAVE_INFO.COUNT])
			} else {
				ds_map_replace(_en, string(ds_map_find_value(global.enemy_names, string(_enemies[i][WAVE_INFO.ENEMY_NAME]))), _enemies[i][WAVE_INFO.COUNT] + ds_map_find_value(_en, string(ds_map_find_value(global.enemy_names, string(_enemies[i][WAVE_INFO.ENEMY_NAME])))))
			}
		}
	}
	keys = ds_map_keys_to_array(_en)
	for (i = 0; i < array_length(keys); i++) {
		if (!obj_room_info.wave_started) {
			draw_text_ext(x+sprite_height, y-sprite_height/2-start_y, string(keys[i])+": x"+ string(ds_map_find_value(_en, keys[i])), 15, 200)
		}
		start_y += y_step
	}
}
