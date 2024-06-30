/// @description Insert description here
// You can write your code in this editor
if (global.enemy_unlocked[index] == false) {
	global.enemy_unlocked[index] = true
	obj_new_unit_info_img.change_skin(index)
}

if (clicked) {
	obj_unit_info_img.change_skin(index, hp, max_hp, ballistic_armor, magic_armor, effect_resist)
}

function create_weapon() {
	if (!layer_sequence_exists("Weapons", weapon_seq) && wpn_anim != noone) {
		weapon_seq = layer_sequence_create("Weapons", x, y, wpn_anim)
		inst_weap = layer_sequence_get_instance(weapon_seq)
		sequence_instance_override_object(inst_weap, weapon, weapon_inst)
		layer_sequence_xscale(weapon_seq, weapon_xscale)
		if (weapon_xscale == 1) {
			layer_sequence_angle(weapon_seq, point_direction(x, y, target.x, target.y))
		} else {
			layer_sequence_angle(weapon_seq, point_direction(target.x, target.y, x, y))
		}
	} else if (!layer_sequence_exists("Weapons", weapon_seq) && instance_exists(weapon_inst)) {
		weapon_inst.image_xscale = weapon_xscale
		if (weapon_xscale == 1) {
			weapon_inst.image_angle = point_direction(x, y, target.x, target.y)
		} else {
			weapon_inst.image_angle = point_direction(target.x, target.y, x, y)
		}
	}
}

function get_origin() {
	potential_origin = noone
	for (i = 0; i < instance_number(obj_enemy_template); i++) {
		potential_origin = instance_find(obj_enemy_template, i)
		if (self == potential_origin) {
			origin = potential_origin
			break
		}
	}
}

function shoot_delay_enable() {
	can_attack = true
	if (!walk_while_distant_attack && state != ENEMY_STATES.DEAD && state != ENEMY_STATES.ATACK && target != noone) {
		state = ENEMY_STATES.ATACK	
	}
}

function shoot_delay_disable() {
	can_attack = false
	// state == ENEMY_STATES.ATACK
	if (!melee_attack && walk_while_distant_attack && state != ENEMY_STATES.DEAD) {
		state = ENEMY_STATES.WALK	
	}
}

function hurt(_dmg) {
	hp -= _dmg * (1 - ballistic_armor)
	if (hp <= 0) {
		hp = 0	
	}
}

function hurt_magic(_dmg) {
	hp -= _dmg * (1 - magic_armor)
	if (hp <= 0) {
		hp = 0	
	}
}

if (hp <= 0) {
	if (target != noone) {
		dead_xscale = (target.x < x) ? -1 : 1
	}
	if (state != ENEMY_STATES.DEAD) {
		dead()	
	}
}

// Тригерр остановки
if (state != ENEMY_STATES.WALK) {
		path_speed = 0
} else {
		path_speed = pth_speed
}


if (current_time - dead_timer > 3*1000 and state == ENEMY_STATES.DEAD) {
	image_alpha -= 1/60
}

if (current_time - dead_timer > 4*1000 and state == ENEMY_STATES.DEAD) {
	layer_sequence_destroy(enemy_seq_walking)
	instance_destroy(self)
}

switch (state) {
	case ENEMY_STATES.WALK: {
		if (layer_sequence_exists("Weapons", weapon_seq)) {
			layer_sequence_destroy(weapon_seq)
			weapon_seq = noone
		}
		if (!layer_sequence_exists("Instances", enemy_seq_walking)) {
			//show_debug_message(11)
			enemy_seq_walking = layer_sequence_create("Instances", x, y, walking_seq)
			enemy_seq_inst = layer_sequence_get_instance(enemy_seq_walking)
			sequence_instance_override_object(enemy_seq_inst, obj_enemy_template, self)
		} else {
			layer_sequence_x(enemy_seq_walking, path_get_x(path_to_go, path_position))	
			layer_sequence_y(enemy_seq_walking, path_get_y(path_to_go, path_position))
			layer_sequence_xscale(enemy_seq_walking, weapon_xscale)
			//show_debug_message(x)
		}
		break;
	} case ENEMY_STATES.ATACK: {
		if (layer_sequence_exists("Instances", enemy_seq_walking)) {
			layer_sequence_destroy(enemy_seq_walking)
			enemy_seq_walking = noone
		}
		break	
	} case ENEMY_STATES.COMPLETED_PATH: {
		if (layer_sequence_exists("Weapons", weapon_seq)) {
			layer_sequence_destroy(weapon_seq)
			weapon_seq = noone
		}
		if (layer_sequence_exists("Instances", enemy_seq_walking)) {
			layer_sequence_destroy(enemy_seq_walking)
			enemy_seq_walking = noone
		}
		break;
	} case ENEMY_STATES.DEAD: {
		if (layer_sequence_exists("Weapons", weapon_seq)) {
			layer_sequence_destroy(weapon_seq)
			weapon_seq = noone
		}
		if (layer_sequence_exists("Instances", enemy_seq_walking)) {
			layer_sequence_destroy(enemy_seq_walking)
			enemy_seq_walking = noone
		}
		if (!layer_sequence_exists("Dead", enemy_seq_dead)) {
			obj_room_info.coins += coin_cost
			enemy_seq_dead = layer_sequence_create("Dead", x, y, dead_seq)
			layer_sequence_xscale(enemy_seq_dead, dead_xscale)
			enemy_seq_inst = layer_sequence_get_instance(enemy_seq_dead)
			sequence_instance_override_object(enemy_seq_inst, obj_enemy_template, self)
		} else {
			layer_sequence_x(enemy_seq_dead, path_get_x(path_to_go, path_position))	
			layer_sequence_y(enemy_seq_dead, path_get_y(path_to_go, path_position))	
			//show_debug_message(x)
		}
		break;
	}
}

if (target != noone) {
	if (instance_exists(target) == false || (attack_every_tower && point_distance(x, y, target.x, target.y) > radius) || (!attack_every_tower && !melee_attack) || state == ENEMY_STATES.DEAD || target.state == TOWER_STATES.DEAD) {
		target = noone;
		not_attacked_melee()
		if (instance_exists(weapon_inst)) {
			instance_destroy(weapon_inst)
		}
	} else {
		if (state != ENEMY_STATES.ATACK) {
			if (!walk_while_distant_attack) {
				state = ENEMY_STATES.ATACK	
			}
		}
		if (target.x < x) {
			image_xscale = -1
			weapon_xscale = -1
		} else {
			image_xscale = 1
			weapon_xscale = 1
		}
		get_origin()
		if (!instance_exists(weapon_inst)) {
			weapon_inst = instance_create_layer(x, y, "Weapons", weapon, {
				origin: origin,
				target: target
			})
		}
		create_weapon()
		if (can_attack) {
			attack()
		}
		
	}
	
} else if (state != ENEMY_STATES.DEAD) {
	if (state == ENEMY_STATES.ATACK) {
		state = ENEMY_STATES.WALK	
	}
	targets = ds_list_create()
	target = noone
	var _targets_cnt = collision_circle_list(x, y, radius, obj_tower_template, true, true, targets, true)
	for (i = 0; i < _targets_cnt; i++) {
		if (attack_every_tower == false) {
			if (targets[| i].state != TOWER_STATES.DEAD && targets[| i].tower_type == TOWER_TYPES.TOWER_MELEE) {
				target = targets[| i]
				break
			}
		} else {
			if (attack_distant_towers) {
				if (targets[| i].state != TOWER_STATES.DEAD) {
					target = targets[| i]
					break
				}
			} else {
				if (targets[| i].state != TOWER_STATES.DEAD && targets[| i].tower_type == TOWER_TYPES.TOWER_MELEE) {
					target = targets[| i]
					break
				}
			}
		}
			
	}
	state = ENEMY_STATES.WALK
	ds_list_destroy(targets)
}

// Необходимость отразить спрайт врага, если тот пошел влево
//show_debug_message(string(x)+" "+string(_xvel))
if (state == ENEMY_STATES.WALK) {
	if (current_time - previous_time >= 1000*0.2) {
		if (x < _xvel) {
			image_xscale = -1
			weapon_xscale = -1
		} else {
			image_xscale = 1
			weapon_xscale = 1
		}
	    _xvel = x; // Записываем значение x в переменную vel
	    previous_time = current_time
	}
}

// Карта состояний врага в зависимости от пройденного расстояния
// Появление красного вопросика над врагом, когда тот почти дошел до финиша
if (path_position > 0.7) {
	if (!near_end and !near_end_anim_ended) {
		near_end_timer = current_time
		near_end_anim_ended = false
		near_end = true
		_seq_near_end_elem = layer_sequence_create("Instances", x, y-sprite_height, seq_near_end_warning)
	}
}

//if (path_position > 0.95) {
//	state = ENEMY_STATES.COMPLETED_PATH
//}
if (path_position == 1) {
	state = ENEMY_STATES.COMPLETED_PATH
	instance_destroy(self)	
}

// Удаление красного вопросика над врагом
if (near_end) {
	layer_sequence_x(_seq_near_end_elem, x)
	layer_sequence_y(_seq_near_end_elem, y-sprite_height)
	if (current_time - near_end_timer >= 2*1000) {
		near_end = false
		near_end_anim_ended = true
		layer_sequence_destroy(_seq_near_end_elem)
	}
}