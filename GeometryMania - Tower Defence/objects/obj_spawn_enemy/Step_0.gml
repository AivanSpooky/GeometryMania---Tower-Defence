/// @description Insert description here
// You can write your code in this editor

if (spawned_enemies == 0 and (current_time - timer) >= _enemy_start_time * 1000) {
	spawned_enemies++
	spawn_enemy()
	delta_time_spawn = random_range(_enemy_next_time-percentaged_time, _enemy_next_time+percentaged_time)
	timer = current_time
}

if (spawned_enemies != 0 and (current_time - timer) >= delta_time_spawn * 1000) {
	spawned_enemies++
	spawn_enemy()
	delta_time_spawn = random_range(_enemy_next_time-percentaged_time, _enemy_next_time+percentaged_time)
	timer = current_time
}

if (spawned_enemies == _enemy_count) {
	obj_room_info.spawner_destroyed()
	instance_destroy(self)
}

