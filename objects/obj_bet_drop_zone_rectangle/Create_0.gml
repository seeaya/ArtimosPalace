/// @description Initialize bet drop zone

event_inherited();

highlight_x = ds_list_create();
highlight_y = ds_list_create();
highlight_width = ds_list_create();
highlight_height = ds_list_create();

// Accept drop if drag item is an obj_chip_store (from dragging from store) or an obj_chip (if dragging from other bet zone)
should_accept_drop = function(item) {
	if (!is_enabled) {
		return false;
	}
	
	if (item.object_index == obj_chip_store) {
		return global.balance >= item.value;
	} else if (item.object_index == obj_chip) {
		return true;
	} else {
		return false;
	}
}

accept_drop = function(item) {
	switch (item.object_index) {
	case obj_chip_store:
		// Dragging from chip store, add value of chip to bet.
		chip.value += item.value;
		global.balance -= item.value;
		break;
	case obj_chip:
		// Dragging from other bet, add other bet to this bet, set other bet to zero (a move).
		var value = item.value;
		item.value = 0;
		chip.value += value;
		break;
	}
	
}

add_chip = function() {
	// Create chip over drop zone, to draw chip when there is a bet
	chip = instance_create_layer(x + sprite_width / 2, y + sprite_height / 2, "Instances", obj_chip);
	
	// Chips scaled by 50%
	chip.image_xscale = 0.5;
	chip.image_yscale = 0.5;
}