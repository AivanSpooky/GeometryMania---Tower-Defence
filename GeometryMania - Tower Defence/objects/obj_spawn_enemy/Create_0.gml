/// @description Insert description here
// You can write your code in this editor

_enemy_object = enemy[0]
_enemy_count = enemy[1]
_enemy_path = enemy[2]
_enemy_start_time = enemy[3]
_enemy_next_time = enemy[4]
_enemy_delta_time = enemy[5]
percentaged_time = _enemy_next_time*_enemy_delta_time/100

timer = current_time
delta_time_spawn = 0
spawned_enemies = 0

function spawn_enemy() {
	instance_create_layer(x, y, "Instances", _enemy_object, {
		path_to_go: _enemy_path
	})
}