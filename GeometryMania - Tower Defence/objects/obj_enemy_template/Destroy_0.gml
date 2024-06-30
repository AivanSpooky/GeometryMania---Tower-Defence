/// @description Insert description here
// You can write your code in this editor

switch state {
	case ENEMY_STATES.COMPLETED_PATH:
		obj_room_info.health_lost(live_cost)
		break
	case ENEMY_STATES.DEAD:
		break
}
if (layer_sequence_exists("Instances", _seq_near_end_elem)) {
	layer_sequence_destroy(_seq_near_end_elem)	
}
if (layer_sequence_exists("Instances", enemy_seq_walking)) {
	layer_sequence_destroy(enemy_seq_walking)	
}
obj_room_info.enemy_destroyed()
