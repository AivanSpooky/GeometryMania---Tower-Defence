/// @description Insert description here
// You can write your code in this editor
if (clicked) {
	obj_unit_info_img.change_skin(index, hp, max_hp, ballistic_armor, magic_armor, effect_resist)
}

function find_nearest_to_end() {
	potential_target = noone
	var max_pos = 0
	for (i = 0; i < instance_number(obj_enemy_template); i++) {
		potential_target = instance_find(obj_enemy_template, i)
		if (state != TOWER_STATES.DEAD && instance_exists(potential_target) && point_distance(x, y, potential_target.x, potential_target.y) <= radius && path_get_length(potential_target.path_to_go)*potential_target.path_position >= max_pos && potential_target.state != ENEMY_STATES.DEAD && potential_target.state != ENEMY_STATES.COMPLETED_PATH && potential_target.is_visible) {
			max_pos = path_get_length(potential_target.path_to_go)*potential_target.path_position
			target = potential_target	
		}
	}
}

function get_origin() {
	potential_origin = noone
	for (i = 0; i < instance_number(obj_tower_template); i++) {
		potential_origin = instance_find(obj_tower_template, i)
		if (self == potential_origin) {
			origin = potential_origin
			break
		}
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
	if (layer_sequence_exists("Instances", tower_seq_dead)) {
		layer_sequence_xscale(tower_seq_dead, dead_xscale)
	}
	if (state != TOWER_STATES.DEAD) {
		dead()	
	}
}

if (current_time - dead_timer > 3*1000 and state == TOWER_STATES.DEAD) {
	image_alpha -= 1/60
}

if (current_time - dead_timer > 4*1000 and state == TOWER_STATES.DEAD) {
	instance_destroy(self)
}

//change_seq()
if (current_time - timer >= 4*1000 && state != TOWER_STATES.DEAD) {
	timer = current_time
	set_sequence()
}

/*if (target != noone) {
	show_debug_message(point_distance(x, y, target.x, target.y))
}*/

if (target != noone) {
	// TODO
	if (tower_type == TOWER_TYPES.TOWER_DISTANT) {
		if (instance_exists(weapon_inst)){
			instance_destroy(weapon_inst)
		}
		find_nearest_to_end()
	}
	if (state == TOWER_STATES.DEAD || instance_exists(target) == false || (tower_type == TOWER_TYPES.TOWER_DISTANT && point_distance(x, y, target.x, target.y) > radius) || (tower_type == TOWER_TYPES.TOWER_MELEE && point_distance(x, y, target.x, target.y) > (radius+60)) || target.state == ENEMY_STATES.DEAD || target.state == ENEMY_STATES.COMPLETED_PATH) {
		target = noone;
		state = TOWER_STATES.IDLE
		if (instance_exists(weapon_inst)) {
			instance_destroy(weapon_inst)
		}
		set_sequence()
	} else {
		if (state != TOWER_STATES.ATACK) {
			state = TOWER_STATES.ATACK
		}
		if (target.x < x) {
			image_xscale = -1
			if (!instance_exists(weapon_inst)) weapon_xscale = -1
		} else {
			image_xscale = 1
			if (!instance_exists(weapon_inst)) weapon_xscale = 1
		}
		if (tower_type == TOWER_TYPES.TOWER_DISTANT) {
			if (!instance_exists(weapon_inst)) {
				weapon_inst = instance_create_layer(x, y, "Weapons", weapon, {
					origin: origin,
					target: target
				})
				set_sequence()	
			} else {
				weapon_inst.target = target	
			}
			if (can_attack) {
				shoot_delay_disable()
				alarm[0] = rate_of_fire * 60
				instance_create_layer(x, y, "Weapons", projectile, {
					dmg: irandom_range(min_dmg, max_dmg),
					fly_speed: fly_speed,
					target: target,
					lifetime: lifetime,
					detect_time: detect_time
				})
			}
		} else if (tower_type == TOWER_TYPES.TOWER_MELEE) {
			target.being_attacked_melee(self)
			if (!instance_exists(weapon_inst)) {
				weapon_inst = instance_create_layer(x, y, "Weapons", weapon, {
					origin: origin,
					target: target
				})
				set_sequence()	
			} else {
				weapon_inst.target = target	
			}
			if (can_attack) {
				shoot_delay_disable()
				alarm[0] = rate_of_fire * 60
				target.hurt(irandom_range(min_dmg, max_dmg))
			}
		}
		
	}
	
} else if ((state != TOWER_STATES.DEAD)) {
	if (state == TOWER_STATES.ATACK) {
		state = TOWER_STATES.IDLE
		set_sequence()	
	}
	target = noone
	set_new_target()
	state = TOWER_STATES.IDLE
}

