/// @description Insert description here
// You can write your code in this editor

// DEBUG

if (keyboard_check_released(ord("A"))) {
	list_for_each(drop_zones_all, function(zone) {
		zone.chip.value = 1;
	})
}