/// @description Initialize drag controller

// True when an item is being dragged
is_dragging = false;

// The item being dragged. If nothing is being dragged, then undefined
drag_item = undefined;

// The sprite to show of the dragging item. If nothing is being dragged, then undefined
drag_sprite = undefined;

// The scale of the sprite to show while dragging.
drag_scale = 1;

// Called when an item should begin to be dragged. If an item is already being dragged, the current drag will be canceled
begin_drag_of_item = function(item) {
	// Cancel current drag
	if (is_dragging) {
		drag_item.drag_canceled();
	}
	
	drag_item = item;
	// drag_sprite() and drag_scale() must be defined on the item initiating the drag
	drag_sprite = item.drag_sprite();
	drag_scale = item.drag_scale();
	is_dragging = true;
};

// Called when accepting a drag. When called, the current drag will be ended
accept_drag = function() {
	if (is_dragging) {
		is_dragging = false;
		drag_item = undefined;
		drag_sprite = undefined;
		drag_scale = 1;
	} else {
		// accept_drag() was called outside of a drag event
		show_debug_message("Called accept_drag outside of a drag event");
		drag_item = undefined;
		drag_sprite = undefined;
		drag_scale = 1;
	}
}
