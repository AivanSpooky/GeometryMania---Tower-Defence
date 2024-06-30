/// @description Insert description here
// You can write your code in this editor
if (target.state == ENEMY_STATES.DEAD || target.state == ENEMY_STATES.COMPLETED_PATH) {
	instance_destroy(self)
}

if (current_time - timer < detect_time*1000) {
	direction = point_direction(x, y, target.x, target.y)
	image_angle = direction - 90
	speed = fly_speed
}
if (current_time - timer >= lifetime*1000) {
	instance_destroy(self)
}