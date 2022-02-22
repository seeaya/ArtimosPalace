/// @description Initialize drop zone

// Color to highlight zone when dragging over (note: only highlights when should_accept_drop() returns true)
drop_highlight_color = c_white;
// Alpha of the highlight zone when dragging over
drop_highlight_alpha = 0.25;

// When room starts, will not be dragging. Should only be visible when an item is being dragged over the drop zone
visible = false;

// Called to see if an item should be allowed to be dropped over this drop zone. This should be overriden by children
should_accept_drop = function(item) {
	return false;
}

// Called when an item has been dropped on the drop zone. should_accept_drop() will have returned true before this is called
// This should be overriden by children
accept_drop = function(item) {
	// Do nothing
}