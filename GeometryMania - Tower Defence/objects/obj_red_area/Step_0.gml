/// @description Insert description here
// You can write your code in this editor
if (show) {
	if (alpha_up and image_alpha < 0.6) {
		image_alpha += 0.2/60
	} else if (alpha_up) {
		alpha_up = false
	} else if (!alpha_up and image_alpha > 0) {
		image_alpha -= 0.2/60
	} else if (!alpha_up) {
		alpha_up = true	
	}
} else {
	image_alpha = 0	
}

