/// @description отрисовка состояния уровня
// You can write your code in this editor

switch state {
	case LOCKED:
		self.image_alpha = 0
		break;
	case UNCOMPLETED:
		self.image_alpha = 1
		self.image_index = 0
		draw_self()
		break
	case COMPLETED:
		self.image_alpha = 1
		self.image_index = 1
		draw_self()
		break
	case SELECTED:
		self.image_index = 2
		draw_self()
		break
}
