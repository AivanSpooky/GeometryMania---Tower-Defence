/// @description Insert description here
// You can write your code in this editor
//var _root_list = ds_list_create()

var _json_string = "{"

_json_string += "\"levels_info\": "
_json_string += json_stringify(global.levels_info)
_json_string += ","

_json_string += "\"starting_money\": "
_json_string += json_stringify(global.starting_money)
_json_string += ","

_json_string += "\"level_stars\": "
_json_string += json_stringify(global.level_stars)
_json_string += ","

_json_string += "\"level_waves_countdown\": "
_json_string += json_stringify(global.level_waves_countdown_save)
_json_string += ","

_json_string += "\"level_waves_info\": "
_json_string += json_stringify(global.level_waves_info_save)
_json_string += ","

_json_string += "\"enemy_names\": "
_json_string += json_stringify(global.enemy_names_save)
_json_string += ","

_json_string += "\"enemy_unlocked\": "
_json_string += json_stringify(global.enemy_unlocked)
_json_string += ","

_json_string += "\"towers_unlocked\": "
_json_string += json_stringify(global.towers_unlocked)
_json_string += ","

_json_string += "\"towers_selected\": "
_json_string += json_stringify(global.towers_selected)

_json_string += "}"

var _file = file_text_open_write("info.json");
file_text_write_string(_file, _json_string);
file_text_close(_file);
