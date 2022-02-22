/// @description Check for drop in circle

// Check if mouse in radius of circle
var dist = point_distance(x, y, mouse_x, mouse_y);
var radius = sprite_height / 2;

// Only show highlight if in radius of drop zone
visible = (dist <= radius) && obj_drag_controller.is_dragging && should_accept_drop(obj_drag_controller.drag_item);

// Check for drag drops
if (dist <= radius) {
	if (mouse_check_button_released(mb_left) && obj_drag_controller.is_dragging && should_accept_drop(obj_drag_controller.drag_item)) {
		accept_drop(obj_drag_controller.drag_item);
		obj_drag_controller.accept_drag();
	}
}
