/// @description Insert description here
// You can write your code in this editor
if (target.type == ENTITY_TYPE.ENEMY && other.state != ENEMY_STATES.DEAD) {
	other.hurt(dmg)
	instance_destroy(self)
}
