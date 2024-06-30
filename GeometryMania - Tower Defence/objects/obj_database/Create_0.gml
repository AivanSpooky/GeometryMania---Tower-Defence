/// @description БАЗА ДАННЫХ ВСЕЙ ИГРЫ
// You can write your code in this editor

// Получаем информацию о волнах из JSON и преобразуем это в глобальную переменную
var _json = file_text_open_read("info.json");
var _json_string = "";
while (!file_text_eof(_json)) {
    _json_string += file_text_readln(_json);
}
file_text_close(_json);

var _data = json_parse(_json_string);
var _data_1 = json_parse(_json_string);

// Информация об уровнях (отображается в rm_map)
// LEVELS_CNT - сколько всего уровней в игре
// levels_info - массив, который хранит информацию о каждом из уровней в состояниях
#macro LEVELS_CNT 22

#macro LOCKED -1
#macro UNCOMPLETED 0
#macro COMPLETED 1
#macro SELECTED 2
global.levels_info = _data.levels_info

global.level_rooms = ds_map_create()
ds_map_add(global.level_rooms, 0, rm_map)
ds_map_add(global.level_rooms, 1, rm_lvl_1)
ds_map_add(global.level_rooms, 2, rm_lvl_2)


global.starting_money = _data.starting_money

// levels_path_info - матрица для описания путей на каждом уровне
// 0-ой элемент: количество путей на уровне
// далее описание путей в виде путевых переменных
//global.levels_path_info = array_create(LEVELS_CNT + 1)
//global.levels_path_info[1][0] = 1
//global.levels_path_info[1][1] = pth_lvl_1_1
//global.levels_info[4] = UNCOMPLETED
//global.levels_info[3] = UNCOMPLETED
//global.levels_info[2] = UNCOMPLETED
//global.levels_info[1] = COMPLETED




global.level_stars = _data.level_stars
/*
for (var i = 0; i < array_length(global.level_stars); i++) {
	for (var j = 0; j < array_length(global.level_stars[i]); j++) {
		
	}
}*/


// Определение переменных в типе данных
// 1: Имя объекта-врага
// 2: Кол-во врагов на волну
// 3: Путь, по которому идет враг
// 4: Сколько секунд от начала волны должно пройти, чтобы появился первый враг
// 5: Сколько времени должно пройти от появления первого врага, до появления следующего
// 6: Погрешность времени в появлении следующего врага (указано в процентах, отнимается или прибавляется к параметру 5)
enum WAVE_INFO {
	ENEMY = 0,
	COUNT = 1,
	PATH = 2,
	START_TIME = 3,
	NEXT_TIME = 4,
	DELTA_TIME = 5,
	ENEMY_NAME = 6
}

global.level_waves_info = _data.level_waves_info
global.level_waves_info_save = _data_1.level_waves_info

for (var i = 0; i < array_length(global.level_waves_info); i++) {
    for (var j = 0; j < array_length(global.level_waves_info[i]); j++) {
		for (var k = 0; k < array_length(global.level_waves_info[i][j]); k++) {
	        var _enemy_info = global.level_waves_info[i][j][k];
			if (array_length(_enemy_info) > 0) {
				var _enemy_object = asset_get_index(_enemy_info[0]); // Получаем объект врага по его имени из JSON-файла
				var _enemy_count = _enemy_info[1];
				var _enemy_path = asset_get_index(_enemy_info[2]); // Получаем путь врага по его имени из JSON-файла
				var _enemy_start_time = _enemy_info[3]
				var _enemy_next_time = _enemy_info[4]
				var _enemy_delta_time = _enemy_info[5]
				var _enemy_object_name = _enemy_info[0]
				//global.level_waves_info_save[i][j][k] = [_enemy_info[0], _enemy_info[1], _enemy_info[2], _enemy_info[3], _enemy_info[4], _enemy_info[5]]
				//global.level_waves_info_save[i][j][k] = _enemy_info
				global.level_waves_info[i][j][k] = [_enemy_object, _enemy_count, _enemy_path, _enemy_start_time, _enemy_next_time, _enemy_delta_time, _enemy_object_name]; // Обновляем значения в global.level_waves_info
			} else {
				//global.level_waves_info_save[i][j][k] = []
				//global.level_waves_info_save[i][j][k] = []
				global.level_waves_info[i][j][k] = []	
			}
		}
    }
}
// КУЛДАУН МЕЖДУ КОНЦОМ ОДНОЙ ВОЛНЫ И НАЧАЛОМ СЛЕДУЮЩЕЙ
global.level_waves_countdown = _data.level_waves_countdown
global.level_waves_countdown_save = _data.level_waves_countdown
for (var i = 0; i < array_length(global.level_waves_countdown); i++) {
	res = []
	for (var j = 0; j < array_length(global.level_waves_countdown[i]); j++) {
		array_push(res, global.level_waves_countdown[i][j])
	}
	global.level_waves_countdown[i] = res
}
// levels_waves - массив, задающий максимальное количество волн на каждом уровне
global.levels_waves = array_create(LEVELS_CNT + 1, 0)
for (var i = 0; i < array_length(global.level_waves_info); i++) {
	global.levels_waves[i] = array_length(global.level_waves_info[i])	
}
//...
global.enemy_names = _data.enemy_names
global.enemy_names_save = _data.enemy_names
enemy_names = ds_map_create()
for (i = 0; i < array_length(global.enemy_names); i += 2) {
	ds_map_add(enemy_names, global.enemy_names[i], global.enemy_names[i+1])
}
global.enemy_names = enemy_names





enum ENTITY_TYPE {
	ENEMY,
	TOWER
}

// Информация о состояниях врага
enum ENEMY_STATES {
	IDLE,
	WALK,
	ATACK,
	DEAD,
	COMPLETED_PATH
}
//ds_map_add(enemy_names)


#macro TOWERS_TYPES_CNT 3
enum TOWER_TYPES {
	TOWER_DISTANT = 0,
	TOWER_MELEE = 1,
	TOWER_OUTPOST = 2
}

#macro TOWERS_CNT 2
enum TOWER_INFO {
	TOWER_ARCHER = 0,
	TOWER_SWORDMAN = 1
}
global.towers_unlocked = _data.towers_unlocked
global.towers_selected = _data.towers_selected
global.enemy_unlocked = _data.enemy_unlocked

// Информация о состоянии выбора башни (можно ли её поставить на уровне)
enum TOWER_BUY_STATES {
	CANT_BUY,
	CAN_BUY
}

enum TOWER_PLACE_STATES {
	CANT_PLACE,
	CAN_PLACE
}

enum TOWER_STATES {
	IDLE,
	ATACK,
	DEAD
}

enum EFFECT_STATES {
	NONE,
	BURN,
	FROZEN,
	POISONED
}

enum UNIT_INFO {
	EMPTY = 0,
	E_WHITE = 1,
	E_SOLDIER = 2,
	E_ARCHER = 3,
	E_LEAFCAMO,
	T_ARCHER = 33,
	T_SWORDMAN = 34
}