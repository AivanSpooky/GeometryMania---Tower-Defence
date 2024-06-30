/// @description Insert description here
// You can write your code in this editor
function set_new_target() {
	var _compare_function = function(a, b) {
    if (path_get_length(targets[| a].path_to_go)*targets[| a].path_position > path_get_length(targets[| b].path_to_go)*targets[| b].path_position) {
	        return 1; // Swap if the path_position of 'a' is greater than 'b'
	    } else if (path_get_length(targets[| a].path_to_go)*targets[| a].path_position < path_get_length(targets[| b].path_to_go)*targets[| b].path_position) {
	        return -1; // Do not swap if the path_position of 'a' is less than 'b'
	    } else {
	        return 0; // Do not swap if the path_position of 'a' is equal to 'b'
	    }
	};

	targets = ds_list_create()
	var _targets_cnt = collision_circle_list(x, y, radius, obj_enemy_template, true, true, targets, false)
	
	ds_list_sort(targets, _compare_function)
	for (i = 0; i < _targets_cnt; i++) {
		if (tower_type == TOWER_TYPES.TOWER_DISTANT) {
			if (targets[| i].state != ENEMY_STATES.DEAD && targets[| i].is_visible) {
				target = targets[| i]
				break
			}
		}
		else if(tower_type == TOWER_TYPES.TOWER_MELEE) {
			//if (targets[| i].state != ENEMY_STATES.DEAD && targets[| i].state != ENEMY_STATES.ATACK) {
			if (targets[| i].state != ENEMY_STATES.DEAD && targets[| i].is_visible) {
				target = targets[| i]
				break
			}
		}
	}
	ds_list_destroy(targets)
}

function shoot_delay_enable() {
	can_attack = true	
}

function shoot_delay_disable() {
	can_attack = false	
}

function dead() {
	state = TOWER_STATES.DEAD
	set_sequence()
	dead_timer = current_time
}

function set_sequence() {
	//if (layer_sequence_exists("Instances", tower_seq_idle)) {
	layer_sequence_destroy(tower_seq_idle)
	//} if (layer_sequence_exists("Instances", tower_seq_attack)) {
	layer_sequence_destroy(tower_seq_attack)
	layer_sequence_destroy(tower_seq_dead)
	layer_sequence_destroy(weapon_seq)
	//}
	switch (state) {
		case TOWER_STATES.IDLE: {
			var _choice = irandom_range(0, 100)
			if (_choice >= 30) {
				tower_seq_idle = layer_sequence_create("Instances", x, y, seq_tower_swordman_idle_1)
			} else if (_choice >= 10 and _choice < 30) {
				tower_seq_idle = layer_sequence_create("Instances", x, y, seq_tower_swordman_idle_2)
			} else {
				tower_seq_idle = layer_sequence_create("Instances", x, y, seq_tower_swordman_idle_3)
			}
			inst_seq = layer_sequence_get_instance(tower_seq_idle)
			sequence_instance_override_object(inst_seq, obj_tower_swordman, self)
			break;
		}
		case TOWER_STATES.ATACK: {
			tower_seq_attack = layer_sequence_create("Instances", x, y, seq_tower_swordman_attack)
			inst_seq = layer_sequence_get_instance(tower_seq_attack)
			//layer_sequence_xscale(tower_seq_attack, image_xscale)
			sequence_instance_override_object(inst_seq, obj_tower_swordman, self)
			if (weapon_xscale == 1) {
				layer_sequence_xscale(tower_seq_attack, 1)	
			} else {
				layer_sequence_xscale(tower_seq_attack, -1)		
			}
			weapon_seq = layer_sequence_create("Weapons", x, y, seq_sword_slash)
			inst_weap = layer_sequence_get_instance(weapon_seq)
			sequence_instance_override_object(inst_weap, obj_sword_template, weapon_inst)
			layer_sequence_xscale(weapon_seq, weapon_xscale)
			break;
		}
		case TOWER_STATES.DEAD: {
			tower_seq_dead = layer_sequence_create("Dead", x, y, seq_tower_death)
			inst_seq = layer_sequence_get_instance(tower_seq_dead)
			sequence_instance_override_object(inst_seq, obj_tower_template, self)
			break;
		}
	}
}

image_speed = 0
image_index = 0

type = ENTITY_TYPE.TOWER
tower_type = TOWER_TYPES.TOWER_MELEE
tower = TOWER_INFO.TOWER_SWORDMAN
index = UNIT_INFO.T_SWORDMAN

weapon = obj_sword_template
weapon_inst = noone
weapon_xscale = 1
//projectile = obj_projectile_template
//fly_speed = 3
//lifetime = 1.5
//detect_time = 0.5

state = TOWER_STATES.IDLE
effect_state = EFFECT_STATES.NONE

max_hp = 14
hp = max_hp
ballistic_armor = 0.25
magic_armor = 0
effect_resist = [false, false, false]
clicked = false

inst_seq = noone
tower_seq_idle = noone
tower_seq_attack = noone
weapon_seq = noone
inst_weap = noone
tower_seq_dead = noone

origin = self
target = noone
targets = ds_list_create()
can_attack = true
rate_of_fire = 1.0
min_dmg = 1
max_dmg = 3

timer = current_time
dead_timer = current_time
dead_xscale = 1

//shoot_cooldown = time_source_create(time_source_game, 1*rate_of_fire, time_source_units_seconds, self.shoot_delay_enable, [], 100)

set_sequence()

