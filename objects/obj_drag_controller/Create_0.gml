/// @description Insert description here
// You can write your code in this editor

is_dragging = false;
drag_item = undefined;
drag_sprite = undefined;
drag_scale = 1;

// Call when starting a drag
begin_drag_of_item = function(item) {
	if (is_dragging) {
		drag_item.drag_canceled();
	}
	
	drag_item = item;
	drag_sprite = item.drag_sprite();
	drag_scale = item.drag_scale();
	is_dragging = true;
};

// Call when accepting a drag
accept_drag = function() {
	if (is_dragging) {
		is_dragging = false;
		drag_item = undefined;
		drag_sprite = undefined;
		drag_scale = 1;
	} else {
		show_debug_message("Called accept_drag outside of a drag event");
		drag_item = undefined;
		drag_sprite = undefined;
		drag_scale = 1;
	}
}
