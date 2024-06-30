/// @description Insert description here
// You can write your code in this editor

randomize()
lighten_seq = layer_sequence_create("End", 0, 0, seq_lighten_map_full)
max_health = 20
lvl_health = 20
coins = global.starting_money[global.level]
max_waves = global.levels_waves[global.level]
lvl_waves = 0
enemies_left = 0
wave_started = false
spawners_left = 0
level_end_timer = current_time
level_ended = false
END = false
FAIL = false
WIN = false
darken_seq = noone
failed_seq_inst = noone
failed_seq = noone

placing_tower = false

#region TEST_INSTANCE_CREATE
//deb = true
#endregion

function hide_hud() {
	move_buy_btn = time_source_create(time_source_game, 1/60, time_source_units_seconds, obj_buy_menu_btn.hide_or_show, [], 100)
	move_life_hud = time_source_create(time_source_game, 1/60, time_source_units_seconds, obj_life_hud_heart.hide_or_show, [], 100)
	move_wave_btn = time_source_create(time_source_game, 1/60, time_source_units_seconds, obj_wave_btn.hide_or_show, [], 100)
	move_pause_btn = time_source_create(time_source_game, 1/60, time_source_units_seconds, obj_pause_btn.hide_or_show, [], 100)
	move_coins = time_source_create(time_source_game, 1/60, time_source_units_seconds, obj_coins.hide_or_show, [], 100)
	time_source_start(move_buy_btn)
	time_source_start(move_life_hud)
	time_source_start(move_wave_btn)
	time_source_start(move_pause_btn)
	time_source_start(move_coins)
}


function hide_buy_menu() {
	event_perform_object(obj_buy_menu_btn, ev_alarm, 0)
}

function play_failed() {
	_failed_text = instance_find(obj_game_over, 0)
	_failed_dest = instance_find(obj_game_over_destr, 0)
	if (_failed_dest.red) {
		failed_seq = layer_sequence_create("End", 0, 0, seq_failed)
	} else {
		failed_seq = layer_sequence_create("End", 0, 0, seq_failed_1)
	}	
	layer_sequence_x(failed_seq, obj_game_over.x)
	layer_sequence_y(failed_seq, obj_game_over.y)
	failed_seq_inst = layer_sequence_get_instance(failed_seq)
	
	sequence_instance_override_object(failed_seq_inst, obj_game_over, _failed_text)
	sequence_instance_override_object(failed_seq_inst, obj_game_over_destr, _failed_dest)
}
function play_dark_seq_end() {
	darken_seq = layer_sequence_create("PauseEndMenus", 0, 0, seq_darken_map)
	layer_sequence_play(darken_seq)
}
function play_dark_seq() {
	darken_seq = layer_sequence_create("BlackScreen", 0, 0, seq_darken_map)
	layer_sequence_play(darken_seq)
}
function delete_dark_seq() {
	if (layer_sequence_exists("BlackScreen", darken_seq) || layer_sequence_exists("BlackScreenEnd", darken_seq)) {
		layer_sequence_destroy(darken_seq)
	}
	darken_seq = noone
}

health_seq_array = []
health_seq_array_cnt = -1
health_seq_timer = current_time
loosing_health = false
function health_lost(_value) {
	loosing_health = true
	health_seq_array_cnt++
	health_seq_timer = current_time
	lvl_health -= _value
	_seq_elem = layer_sequence_create("Instances", obj_life_hud_heart.x, obj_life_hud_heart.y, seq_life_damaged)
	_seq_inst = layer_sequence_get_instance(_seq_elem)
	sequence_instance_override_object(_seq_inst, obj_life_hud_heart, instance_find(obj_life_hud_heart, 0))
	health_seq_array[health_seq_array_cnt] = _seq_elem
	if (lvl_health <= 0) {
		lvl_health = 0
		if (END == false) {
			END = true
			level_end_fail()
		}
	}
}
function wave_start() {
	if (lvl_waves == 0) {
		enemies_left = 1
	}
	lvl_waves += 1
	wave_started = true
	var _level = global.level
	var _enemies = global.level_waves_info[_level][lvl_waves-1]
	spawners_left = array_length(_enemies)
	for (i = 0; i < array_length(_enemies); i++) {
		if (i == 0) and (lvl_waves == 1) {
			enemies_left = _enemies[i][WAVE_INFO.COUNT]
		} else {
			enemies_left += _enemies[i][WAVE_INFO.COUNT]
		}
		instance_create_layer(-1000, 1000, "Instances", obj_spawn_enemy, {
			enemy: 	_enemies[i]
		})	
	}
}
function wave_end() {
	wave_started = false
	obj_wave_btn.pressed = false
	make_pre_wave()
}
function spawner_destroyed() {
	spawners_left--
	if (spawners_left == 0) {
		wave_end()
	}
}
function enemy_destroyed() {
	enemies_left--
}
function level_end() {
	//event_perform_object(obj_buy_menu_btn, ev_user0, 0)
	END = true
	WIN = true
	
	global.levels_info[global.level] = COMPLETED
	if (global.level + 1 <= LEVELS_CNT && global.levels_info[global.level + 1] == LOCKED) {
		global.levels_info[global.level + 1] = UNCOMPLETED
	}
	
	global.level_stars[global.level][0] = 1
	if (lvl_health > 15) {
		global.level_stars[global.level][1] = 1
	}
	if (lvl_health >= 20) {
		global.level_stars[global.level][2] = 1
	}
	
	layer_destroy_instances("Instances")
	draw_sprite(object_get_sprite(obj_wave_btn), 2, obj_wave_btn.x, obj_wave_btn.y)
	instance_deactivate_object(obj_wave_btn)
	play_dark_seq_end()
}

function level_end_fail() {
	//event_perform_object(obj_buy_menu_btn, ev_user0, 0)
	END = true
	FAIL = true
	play_failed()
	layer_destroy_instances("Instances")
	draw_sprite(object_get_sprite(obj_wave_btn), 2, obj_wave_btn.x, obj_wave_btn.y)
	instance_deactivate_object(obj_wave_btn)
	//instance_deactivate_layer("Instances")
	play_dark_seq_end()
}

function make_pre_wave() {
	if (wave_started == false and lvl_waves != max_waves) {
		var _enemies = global.level_waves_info[global.level][lvl_waves]
		var paths = []
		var ind = 0
		for (i = 0; i < array_length(_enemies); i++) {
			path = _enemies[i][WAVE_INFO.PATH]
			if (!array_contains(paths, path)) {
				paths[ind] = path
				ind++
			}
		}
		for (i = 0; i < array_length(paths); i++) {
			instance_create_layer(x, y, "Instances", obj_upcoming_wave, {
				cur_path: paths[i]
			})	
		}
	}	
}

make_pre_wave()