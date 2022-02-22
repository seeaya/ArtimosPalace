/// @description Draw highlight if in zone

if (visible) {
	// Draw circle over drop zone
	draw_set_color(drop_highlight_color);
	draw_set_alpha(drop_highlight_alpha);
	draw_circle(x, y, sprite_width / 2, 0);
}