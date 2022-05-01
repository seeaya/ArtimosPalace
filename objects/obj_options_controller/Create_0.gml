/// @description Insert description here
// You can write your code in this editor

resolution_label = undefined;
button_previous_resolution = undefined;
button_next_resolution = undefined;
button_add_balance_100 = undefined;
button_add_balance_1000 = undefined;
button_add_balance_10000 = undefined;
button_set_balance_100 = undefined;
button_set_balance_1000 = undefined;
button_set_balance_10000 = undefined;
button_menu = undefined;

load_interface_vars_from_room()

set_resolution_label_text = function() {
	resolution_label.text = string(global.resolution.width) + "x" + string(global.resolution.height)
}

set_resolution_label_text();

button_previous_resolution.action = function() {
	with obj_window_controller {
		resolution_index -= 1;
		
		if (resolution_index < 0) {
			resolution_index = ds_list_size(supported_resolutions) - 1;
		}
		
		global.resolution = supported_resolutions[| resolution_index];
		apply_resolution();
	}
	
	set_resolution_label_text();
}

button_next_resolution.action = function() {
	with obj_window_controller {
		resolution_index += 1;
		
		if (resolution_index >= ds_list_size(supported_resolutions)) {
			resolution_index = 0;
		}
		
		global.resolution = supported_resolutions[| resolution_index];
		apply_resolution();
	}
	
	set_resolution_label_text();
}

button_add_balance_100.action = function() {
	global.balance += 100;
}

button_add_balance_1000.action = function() {
	global.balance += 1000;
}

button_add_balance_10000.action = function() {
	global.balance += 10000;
}

button_set_balance_100.action = function() {
	global.balance = 100;
}

button_set_balance_1000.action = function() {
	global.balance = 1000;
}

button_set_balance_10000.action = function() {
	global.balance = 10000;
}

button_menu.action = function() {
	room_goto(rm_main_menu);
}
