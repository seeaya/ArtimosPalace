/// @description Initialize chip

// The value of the chips (note, chips stack)
value = 0;
draggable = true;
depth = -50;

drag_sprite = function() {
	return sprite_index;
}

drag_canceled = function() {
	// Do nothing
}

drag_scale = function() {
	return sprite_width / sprite_get_width(sprite_index);
}