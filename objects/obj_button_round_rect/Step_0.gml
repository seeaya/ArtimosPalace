/// @description Insert description here
// You can write your code in this editor

var padding = 16;

var left = x - sprite_width / 2 + padding;
var right = x + sprite_width / 2 - padding;
var top = y - sprite_height / 2 + padding;
var bottom = y + sprite_height / 2 - padding;

is_hovering = point_in_rectangle(mouse_x, mouse_y, left, top, right, bottom);

if (mouse_check_button_pressed(mb_left) && is_hovering) {
	is_pressed = true;
}

if (mouse_check_button_released(mb_left)) {
	if (is_hovering && is_enabled) {
		action();
	}
	is_pressed = false;
}