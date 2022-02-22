/// @description Initialize chip store drop zone

event_inherited();

// Accept drops of chips from other bet zones
should_accept_drop = function(item) {
	return item.object_index == obj_chip;
}

// When dropping a bet from another zone, set the bet from the zone to zero (moving bet back to balance)
accept_drop = function(item) {
	item.value = 0;
}