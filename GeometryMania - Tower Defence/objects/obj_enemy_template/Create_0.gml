/// @description Insert description here
// You can write your code in this editor
function attack() {
	image_index = 1
	shoot_delay_disable()
	alarm[0] = rate_of_fire * 60
	//target.hurt(irandom_range(min_dmg, max_dmg))
	if (need_proj_attack) {
		instance_create_layer(x, y, "Weapons", projectile, {
			dmg: irandom_range(min_dmg, max_dmg),
			fly_speed: 3,
			target: target,
			lifetime: 5,
			detect_time: 0.2
		})
	}	
}

function is_attacked_melee() {
	image_index = 1
	melee_attack = true
	if (state != ENEMY_STATES.DEAD) {
		state = ENEMY_STATES.ATACK
	}
}

function not_attacked_melee() {
	image_index = 0
	melee_attack = false
	if (state != ENEMY_STATES.DEAD) {
		state = ENEMY_STATES.WALK
	}
}

function being_attacked_melee(_unit) {
	if (state != ENEMY_STATES.DEAD) {
		is_attacked_melee()
		target = _unit
	}
}

function dead() {
	state = ENEMY_STATES.DEAD
	dead_timer = current_time
}

// CHANGE PARAMS
type = ENTITY_TYPE.ENEMY
index = UNIT_INFO.E_WHITE
live_cost = 1
walk_speed = 1
speed_ratio = 1.0
coin_cost = 15
pth_speed = walk_speed*speed_ratio
max_hp = 10
hp = max_hp
ballistic_armor = 0
magic_armor = 0
// fire - ice - poison
effect_resist = [false, false, false]
//

is_visible = true
state = ENEMY_STATES.WALK
effect_state = EFFECT_STATES.NONE
image_speed = 0
stop = false
clicked = false

melee_attack = false
attack_every_tower = true
attack_distant_towers = false
walk_while_distant_attack = false
need_proj_attack = true
projectile = obj_projectile_template
radius = 190 + 190 * random_range(-0.1, 0.1)
origin = self
target = noone
targets = ds_list_create()

weapon = obj_bow_template
wpn_anim = noone
weapon_seq = noone
weapon_xscale = image_xscale
inst_weap = noone
weapon_inst = noone


can_attack = true
rate_of_fire = 2.0
min_dmg = 1
max_dmg = 3

dead_timer = current_time
dead_xscale = 1

// Анимации врага
enemy_seq_inst = noone
walking_seq = seq_enemy_walking
enemy_seq_walking = noone
enemy_seq_dead = noone
dead_seq = seq_enemy_death


_xvel = x
previous_time = current_time

near_end = false
near_end_anim_ended = false
_seq_near_end_elem = noone
near_end_timer = current_time


path_start(path_to_go, pth_speed, path_action_stop, true)


