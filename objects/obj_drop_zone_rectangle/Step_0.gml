/// @description Check for drop in zone

// Check if drop is in rectangle zone
var left_x = x - sprite_width / 2;
var right_x = x + sprite_width / 2;
var top_y = y - sprite_height / 2;
var bottom_y = y + sprite_height / 2;

var in_bounds = point_in_rectangle(mouse_x, mouse_y, left_x, top_y, right_x, bottom_y);

// Only show highlight if in drop rectangle
visible = in_bounds && obj_drag_controller.is_dragging && should_accept_drop(obj_drag_controller.drag_item);

// Check for drag drops
if (in_bounds) {
	if (mouse_check_button_released(mb_left) && obj_drag_controller.is_dragging && should_accept_drop(obj_drag_controller.drag_item)) {
		accept_drop(obj_drag_controller.drag_item);
		obj_drag_controller.accept_drag();
	}
}
