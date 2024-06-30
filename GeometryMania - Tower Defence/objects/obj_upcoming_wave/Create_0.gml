/// @description Insert description here
// You can write your code in this editor
image_speed = 0
mouse_entered = false
mouse_clicked = false
flag = true
path_start(cur_path, 0, path_action_stop, true)
path_speed = 0
path_position = 250/path_get_length(cur_path)
//path_position = 0.13

scale = image_xscale
step = 1/60/4
start_y = 0
y_step = 15
delta = 0

dissappear_seq = noone

function destruction() {
	if (layer_sequence_exists("Instances", dissappear_seq)) {
		layer_sequence_destroy(dissappear_seq)
	}
	instance_destroy(self)
}
