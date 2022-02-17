/// @description Insert description here
// You can write your code in this editor

var dist = point_distance(x, y, mouse_x, mouse_y);
var radius = sprite_height / 2;

visible = (dist <= radius) && mouse_check_button(mb_left);

// Check for drag drops
if (dist <= radius) {
	if (mouse_check_button_released(mb_left) && obj_drag_controller.is_dragging) {
		if (obj_drag_controller.drag_item.object_index == obj_chip) {
			var chip = obj_drag_controller.drag_item;
			obj_drag_controller.accept_drag();
			chip.x = x;
			chip.y = y;
		}
	}
}

