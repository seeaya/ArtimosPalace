/// @description Highlight zone if in rectangle

// Only draw highlight when in zone
if (visible) {
	draw_set_color(drop_highlight_color);
	draw_set_alpha(drop_highlight_alpha);
	draw_rectangle(x, y, x + sprite_width, y + sprite_height, false);
}