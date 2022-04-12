/// @description Register for drops

drag_sprite = function() {
	return sprite_index;
}

drag_canceled = function() {
	// Do nothing
}

drag_scale = function() {
	if (room == rm_roulette) {
		return 0.5;
	}
	
	return sprite_width / sprite_get_width(sprite_index);
}

// Value can be set in the room to determine which sprite to draw
sprite_index = labeled_sprite_for_chip_value(value);


