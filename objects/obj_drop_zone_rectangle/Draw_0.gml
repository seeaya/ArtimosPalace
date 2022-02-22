/// @description Highlight zone if in rectangle

// Only draw highlight when in zone
if (visible) {
	draw_set_color(drop_highlight_color);
	draw_set_alpha(drop_highlight_alpha);
	draw_rectangle(x - sprite_width / 2, y - sprite_height / 2, x + sprite_width / 2, y + sprite_height / 2, false);
}