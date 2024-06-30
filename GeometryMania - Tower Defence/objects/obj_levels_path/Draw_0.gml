/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_red); // Устанавливаем цвет линии (белый в данном случае)
draw_set_alpha(1)
for (i = 1; i < max_level; i++) {
	if (choose_level_buttons[i+1, 2] != LOCKED) {
		draw_arrow(choose_level_buttons[i, 0], choose_level_buttons[i, 1], choose_level_buttons[i+1, 0], choose_level_buttons[i+1, 1], 20)
		draw_line_width(choose_level_buttons[i, 0], choose_level_buttons[i, 1], choose_level_buttons[i+1, 0], choose_level_buttons[i+1, 1], 2);
	}//show_debug_message(string(choose_level_buttons[i, 0]) + " " + string(choose_level_buttons[i, 1]))
	//draw_line(choose_level_buttons[i, 0], choose_level_buttons[i, 1], choose_level_buttons[i+1, 0], choose_level_buttons[i+1, 1])
}
