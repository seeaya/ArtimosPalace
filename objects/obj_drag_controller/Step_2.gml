/// @description Check for drag end

// If the left mouse button is released, cancel the current drag event
if (mouse_check_button_released(mb_left)) {
	if (is_dragging) {
		drag_item.drag_canceled();
		
		drag_item = undefined;
		drag_sprite = undefined;
		drag_scale = 1;
		is_dragging = false;
	}
}