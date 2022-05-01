/// @description Insert description here
// You can write your code in this editor

if (is_pressed) {
	draw_set_color(c_white);
	draw_set_alpha(0.4);
	draw_rectangle(x, y, x + sprite_width, y + sprite_height, 0);
} else if (is_hovering) {
	draw_set_color(c_white);
	draw_set_alpha(0.2);
	draw_rectangle(x, y, x + sprite_width, y + sprite_height, 0);
}
