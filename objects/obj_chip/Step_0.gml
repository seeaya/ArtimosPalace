/// @description Check for drag

// Drag zone is a circle centered on the sprite
var dist = point_distance(x, y, mouse_x, mouse_y);
var radius = sprite_get_height(sprite_index) / 2;

// Check for pressing inside drag radius (don't allow drag for value of zero)
if (draggable && mouse_check_button_pressed(mb_left) && dist <= radius && value > 0) {
	obj_drag_controller.begin_drag_of_item(self);
}

// Dim self while dragging
if (obj_drag_controller.is_dragging && obj_drag_controller.drag_item == self) {
	image_alpha = 0.5;
} else {
	image_alpha = 1;
}