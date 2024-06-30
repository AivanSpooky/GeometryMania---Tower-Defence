/// @description DEBUG PRINTS
// You can write your code in this editor

#region DEBUG_PRINTS
//show_debug_message(string(lvl_waves)+"/"+string(max_waves))
//show_debug_message(string(lvl_health)+"/"+string(max_health))
#endregion

#region TEST_INSTANCE_CREATE
//if (deb and current_time - health_seq_timer > 1*1000) {
	//deb = false;
	//instance_create_layer(0, 0, "Instances", obj_enemy_template, 
	//{
		//path_to_go: pth_lvl_1_1
	//})	
//}
#endregion


if (loosing_health and current_time - health_seq_timer > 1*1000) {
	loosing_health = false
	while (health_seq_array_cnt >= 0) {
		layer_sequence_destroy(health_seq_array[health_seq_array_cnt])
		health_seq_array[health_seq_array_cnt] = noone
		health_seq_array_cnt -= 1
	}
}

if (lvl_waves == max_waves and enemies_left == 0 and wave_started == false and spawners_left == 0 and !END) {
	if (!level_ended) {
		level_end_timer = current_time
	}
	level_ended = true
	if (current_time - level_end_timer >= 3*1000) {
		level_end()
	}
}

// NEED TO CONNECT
/*
if (!WIN && !FAIL) {
	if (current_time - level_end_timer >= 1*1000) {
		level_end_fail()
	}
}*/