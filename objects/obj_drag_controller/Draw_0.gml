/// @description Draw the dragging item

// Only draw when a drag event is active
if (is_dragging) {
	// Draw drag sprite over current mouse location
	draw_sprite_ext(drag_sprite, -1, mouse_x, mouse_y, drag_scale, drag_scale, 0, c_white, 255);
}