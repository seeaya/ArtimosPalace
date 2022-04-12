/// @description Change resolution with +/- buttons

// TODO: Eventually, resolution settings should be moved to a menu

if (keyboard_check_pressed(109)) {
	resolution_index -= 1;
	resolution_index = clamp(resolution_index, 0, ds_list_size(supported_resolutions) - 1);
	global.resolution = supported_resolutions[| resolution_index];
	apply_resolution();
}

if (keyboard_check_pressed(24)) {
	resolution_index += 1;
	resolution_index = clamp(resolution_index, 0, ds_list_size(supported_resolutions) - 1);
	global.resolution = supported_resolutions[| resolution_index];
	apply_resolution();
}

if (keyboard_check(vk_shift) && keyboard_check_released(ord("R"))) {
	room_goto(rm_roulette);
}

if (keyboard_check(vk_shift) && keyboard_check_released(ord("B"))) {
	room_goto(rm_blackjack);
}