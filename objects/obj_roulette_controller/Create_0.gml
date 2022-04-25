/// @description Insert description here
// You can write your code in this editor

// Roulette requires dragging, so create drag controller
instance_create_layer(0, 0, "Instances", obj_drag_controller);

wheel = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_roulette_wheel);
wheel.depth = -50;

winning_number = k_roulette_zero;
stage = roulette_game_stage_type.betting;

#region Drop zones

drop_zone_zero = undefined;
drop_zone_double_zero = undefined;
drop_zone_zero_split = undefined;
drop_zones_straight_ups = ds_list_create();
drop_zones_splits_vertical = ds_list_create();
drop_zones_splits_horizontal = ds_list_create();
drop_zones_corners = ds_list_create();
drop_zones_streets = ds_list_create();
drop_zones_double_streets = ds_list_create();
drop_zone_five_number = undefined;
drop_zone_three_number = undefined;
drop_zones_dozens = ds_list_create();
drop_zones_columns = ds_list_create();
drop_zone_red = undefined;
drop_zone_black = undefined;
drop_zone_odd = undefined;
drop_zone_even = undefined;
drop_zone_low = undefined;
drop_zone_high = undefined;

drop_zones_all = ds_list_create();

create_drop_zone = function(x, y, width, height) {
	drop_zone = instance_create_layer(x, y, "Instances", obj_bet_drop_zone_rectangle);
	drop_zone.image_xscale = width / 128;
	drop_zone.image_yscale = height / 128;
	
	drop_zone.add_chip();
	return drop_zone;
};

set_drop_zone_size = function(obj, hx, hy, hw, hh) {
	ds_list_add(obj.highlight_x, hx);
	ds_list_add(obj.highlight_y, hy);
	ds_list_add(obj.highlight_width, hw);
	ds_list_add(obj.highlight_height, hh);
}

create_drop_zones = function() {
	var inside_x = 622;
	var inside_y = 420;
	var inside_width = 220;
	var inside_height = 275;
	var inside_padding = 50;
	
	// Zeros
	var zero_x = 358;
	var zero_y = 420;
	var zero_width = 264 - inside_padding;
	var zero_height = 412.5 - inside_padding;
	
	drop_zone_double_zero = create_drop_zone(zero_x, zero_y, zero_width, zero_height)
	set_drop_zone_size(drop_zone_double_zero, zero_x, zero_y, zero_width + inside_padding, zero_height + inside_padding);
	drop_zone_zero = create_drop_zone(zero_x, zero_y + zero_height + 2 * inside_padding, zero_width, zero_height);
	set_drop_zone_size(drop_zone_zero, zero_x, zero_y + zero_height + inside_padding, zero_width + inside_padding, zero_height + inside_padding);
	
	drop_zone_zero_split = create_drop_zone(zero_x, zero_y + zero_height, zero_width, inside_padding * 2);
	set_drop_zone_size(drop_zone_zero_split, zero_x, zero_y, zero_width + inside_padding, 2 * (zero_height + inside_padding));
	
	
	// Straight ups
	var straight_width = inside_width - 2 * inside_padding;
	var straight_height = inside_height - 2 * inside_padding;
	
	for (var row = 0; row < 12; ++row) {
		for (var col = 2; col >= 0; --col) {
			var straight_x = inside_x + row * inside_width + inside_padding;
			var straight_y = inside_y + col * inside_height + inside_padding;
			
			var drop_zone = create_drop_zone(straight_x, straight_y, straight_width, straight_height);
			set_drop_zone_size(drop_zone, straight_x - inside_padding, straight_y - inside_padding, straight_width + 2 * inside_padding, straight_height + 2 * inside_padding);
			ds_list_add(drop_zones_straight_ups, drop_zone);
		}
	}
	
	// Horizontal Splits
	var corner_width = inside_padding * 2;
	var corner_height = inside_padding * 2;
	
	for (var row = 1; row < 12; ++row) {
		for (var col = 2; col >= 0; --col) {
			var split_x = inside_x - inside_padding + row * inside_width;
			var split_y = inside_y + col * inside_height + inside_padding;
			
			var drop_zone = create_drop_zone(split_x, split_y, corner_width, straight_height);
			set_drop_zone_size(drop_zone, split_x + inside_padding - inside_width, split_y - inside_padding, inside_width * 2, inside_height);
			ds_list_add(drop_zones_splits_horizontal, drop_zone);
		}
	}
	
	// Vertical Splits
	for (var row = 0; row < 12; ++row) {
		for (var col = 2; col >= 1; --col) {
			var split_x = inside_x + row * inside_width + inside_padding;
			var split_y = inside_y - inside_padding + col * inside_height;
			
			var drop_zone = create_drop_zone(split_x, split_y, straight_width, corner_height);
			set_drop_zone_size(drop_zone, split_x - inside_padding, split_y + inside_padding - inside_height, inside_width, inside_height * 2);
			ds_list_add(drop_zones_splits_vertical, drop_zone);
		}
	}
	
	// Corners
	for (var row = 1; row < 12; ++row) {
		for (var col = 2; col >= 1; --col) {
			var corner_x = inside_x - inside_padding + row * inside_width;
			var corner_y = inside_y - inside_padding + col * inside_height;
			
			var drop_zone = create_drop_zone(corner_x, corner_y, corner_width, corner_height);
			set_drop_zone_size(drop_zone, corner_x + inside_padding - inside_width, corner_y + inside_padding - inside_height, 2 * inside_width, 2 * inside_height);
			ds_list_add(drop_zones_corners, drop_zone);
		}
	}
	
	// Streets
	var street_y = inside_y + 3 * inside_height - inside_padding;
	
	for (var row = 0; row < 12; ++row) {
		var street_x = inside_x + row * inside_width + inside_padding;
		
		var drop_zone = create_drop_zone(street_x, street_y, straight_width, corner_height);
		set_drop_zone_size(drop_zone, street_x - inside_padding, inside_y, inside_width, inside_height * 3);
		ds_list_add(drop_zones_streets, drop_zone);
	}
	
	// Double streets
	for (var row = 1; row < 12; ++row) {
		var street_x = inside_x - inside_padding + row * inside_width;
		
		var drop_zone = create_drop_zone(street_x, street_y, corner_width, corner_height);
		set_drop_zone_size(drop_zone, street_x + inside_padding - inside_width, inside_y, inside_width * 2, inside_height * 3);
		ds_list_add(drop_zones_double_streets, drop_zone);
	}
	
	// Five number bet
	var five_number_x = inside_x - inside_padding;
	var five_number_y = inside_y + 3 * inside_height - inside_padding;
	drop_zone_five_number = create_drop_zone(five_number_x, five_number_y, corner_width, corner_height);
	set_drop_zone_size(drop_zone_five_number, zero_x, zero_y, zero_width + inside_padding + inside_width, inside_height * 3);
	
	// Three number bet
	var three_number_x = five_number_x;
	var three_number_y = inside_y + 1.5 * inside_height - inside_padding;
	drop_zone_three_number = create_drop_zone(three_number_x, three_number_y, corner_width, corner_height);
	set_drop_zone_size(drop_zone_three_number, zero_x, zero_y, zero_width + inside_padding, 2 * (zero_height + inside_padding));
	set_drop_zone_size(drop_zone_three_number, inside_x, inside_y + inside_height, inside_width, inside_height);
	
	// Dozens
	var dozen_y = inside_y + 3 * inside_height + inside_padding;
	var dozen_width = inside_width * 4;
	var dozen_height = 220 - inside_padding;
	
	for (var i = 0; i < 3; ++i) {
		var dozen_x = inside_x + i * 4 * inside_width;
		
		var drop_zone = create_drop_zone(dozen_x, dozen_y, dozen_width, dozen_height);
		set_drop_zone_size(drop_zone, dozen_x, dozen_y - inside_padding, dozen_width, dozen_height + inside_padding);
		ds_list_add(drop_zones_dozens, drop_zone);
	}
	
	// Columns
	var column_x = inside_x + 12 * inside_width;
	
	for (var i = 2; i >= 0; --i) {
		var column_y = inside_y + i * inside_height;
		
		var drop_zone = create_drop_zone(column_x, column_y, inside_width, inside_height);
		ds_list_add(drop_zones_columns, drop_zone);
	}
	
	// Red/Black
	var outside_x = inside_x;
	var outside_y = dozen_y + dozen_height;
	var outside_width = 2 * inside_width;
	var outside_height = inside_height;
	
	drop_zone_red = create_drop_zone(outside_x + outside_width * 2, outside_y, outside_width, outside_height);
	drop_zone_black = create_drop_zone(outside_x + outside_width * 3, outside_y, outside_width, outside_height);
	
	// Odd/Even
	drop_zone_even = create_drop_zone(outside_x + outside_width * 4, outside_y, outside_width, outside_height);
	drop_zone_odd = create_drop_zone(outside_x + outside_width, outside_y, outside_width, outside_height);
	
	// High/Low
	drop_zone_low = create_drop_zone(outside_x, outside_y, outside_width, outside_height);
	drop_zone_high = create_drop_zone(outside_x + outside_width * 5, outside_y, outside_width, outside_height);
	
	list_append_list(drop_zones_all, drop_zones_straight_ups);
	list_append_list(drop_zones_all, drop_zones_splits_horizontal);
	list_append_list(drop_zones_all, drop_zones_splits_vertical);
	list_append_list(drop_zones_all, drop_zones_corners);
	list_append_list(drop_zones_all, drop_zones_streets);
	list_append_list(drop_zones_all, drop_zones_double_streets);
	list_append_list(drop_zones_all, drop_zones_columns);
	list_append_list(drop_zones_all, drop_zones_dozens);
	ds_list_add(drop_zones_all, drop_zone_zero);
	ds_list_add(drop_zones_all, drop_zone_double_zero);
	ds_list_add(drop_zones_all, drop_zone_zero_split);
	ds_list_add(drop_zones_all, drop_zone_five_number);
	ds_list_add(drop_zones_all, drop_zone_three_number);
	ds_list_add(drop_zones_all, drop_zone_red);
	ds_list_add(drop_zones_all, drop_zone_black);
	ds_list_add(drop_zones_all, drop_zone_high);
	ds_list_add(drop_zones_all, drop_zone_low);
	ds_list_add(drop_zones_all, drop_zone_odd);
	ds_list_add(drop_zones_all, drop_zone_even);
};

value_for_inside = function(row, col) {
	return row * 3 + col + 1;
}

value_for_dzi_straight_up = function(index) {
	return index + 1;
}

value_for_dzi_splits_vertical = function(index) {
	var row = index div 2;
	var col = (index % 2) + 1;
	return value_for_inside(row, col);
}

value_for_dzi_splits_horizontal = function(index) {
	return index + 1;
}

value_for_dzi_corners = function(index) {
	return value_for_dzi_splits_vertical(index);
}

#endregion

chips_taken = ds_list_create();

chips_player_location_x = room_width / 2;
chips_player_location_y = room_height + sprite_get_height(spr_chip_white) / 2;

chips_dealer_location_x = room_width / 2;
chips_dealer_location_y = -sprite_get_height(spr_chip_white) / 2;

push_chip = function(chip) {
	var path = path_add();
	path_add_point(path, chip.x, chip.y, 1);
	path_add_point(path, chips_player_location_x, chips_player_location_y, 1);
	path_set_closed(path, false);
	
	with (chip) {
		path_start(path, 2000, path_action_stop, true);
	}
}

win_chip = function(amount, x_location) {
	var chip = instance_create_layer(x_location, chips_dealer_location_y, "Instances", obj_chip);
	chip.draggable = false;
	chip.value = amount;
	chip.image_xscale = 0.5;
	chip.image_yscale = 0.5;
	
	var path = path_add();
	path_add_point(path, x_location, chips_dealer_location_y, 1);
	path_add_point(path, chips_player_location_x, chips_player_location_y, 1);
	path_set_closed(path, false);
	
	with (chip) {
		path_start(path, 2000, path_action_stop, true);
	}
	
	ds_list_add(chips_taken, chip);
}

lose_chip = function(chip) {
	var path = path_add();
	path_add_point(path, chip.x, chip.y, 1);
	path_add_point(path, chips_dealer_location_x, chips_dealer_location_y, 1);
	path_set_closed(path, false);
	
	with (chip) {
		path_start(path, 2000, path_action_stop, true);
	}
}

payout_chip = function(zone, multiplier) {
	var chip = zone.chip;
	
	with zone {
		self.chip = instance_create_layer(x + sprite_width / 2, y + sprite_height / 2, "Instances", obj_chip);
		self.chip.image_xscale = 0.5;
		self.chip.image_yscale = 0.5;
	}
	
	if (multiplier == -1) {
		lose_chip(chip);
	} else if (multiplier == 0) {
		push_chip(chip);
	} else {
		var win_amount = multiplier * chip.value;
		push_chip(chip);
		win_chip(win_amount, chip.x);
	}
	
	global.balance += chip.value * (multiplier + 1)
	
	ds_list_add(chips_taken, chip);
}

#region Game transition functions

begin_betting = function() {
	stage = roulette_game_stage_type.betting;
	
	list_for_each(chips_taken, function(chip) {
		instance_destroy(chip, true);
	});
	
	ds_list_destroy(chips_taken);
	chips_taken = ds_list_create();
	
	wheel.visible = false;
	
	game_button_top_left.text = "Repeat";
	game_button_bottom_left.text = "Double";
	game_button_top_right.text = "Clear";
	game_button_bottom_right.text = "Spin";
	
	game_button_top_left.is_enabled = true;
	game_button_bottom_left.is_enabled = true;
	game_button_top_right.is_enabled = true;
	game_button_bottom_right.is_enabled = true;
	
	last_number_label.visible = false;
	
	list_for_each(drop_zones_all, function(zone) {
		zone.is_enabled = true;
		zone.chip.draggable = true;
	});
}

begin_spin = function() {
	stage = roulette_game_stage_type.wheel_spinning;
	
	game_button_top_left.is_enabled = false;
	game_button_bottom_left.is_enabled = false;
	game_button_top_right.is_enabled = false;
	game_button_bottom_right.is_enabled = false;
	
	list_for_each(drop_zones_all, function(zone) {
		zone.is_enabled = false;
		zone.chip.draggable = false;
	});
	
	// TODO: Spin wheel
	winning_number = irandom_range(1, 38);
	if (winning_number == 37) {
		winning_number = k_roulette_zero;
	} else if (winning_number == 38) {
		winning_number = k_roulette_double_zero;
	}
	
	var text;
	
	if (winning_number == k_roulette_zero) {
		text = "0";
	} else if (winning_number == k_roulette_double_zero) {
		text = "00";
	} else {
		text = string(winning_number);
	}
	
	last_number_label.text = text;
	last_number_label.visible = true;
	
	wheel.visible = true;
	wheel.spin(winning_number);
	
	alarm[0] = 12 * room_speed;
}

begin_payout = function() {
	stage = roulette_game_stage_type.payout;
	
	wheel.visible = false;
	
	var text;
	
	if (winning_number == k_roulette_zero) {
		text = "0";
	} else if (winning_number == k_roulette_double_zero) {
		text = "00";
	} else {
		text = string(winning_number);
	}
	
	last_number_label.text = text;
	last_number_label.visible = true;
	
	// Payout straight ups
	if (rl_is_straight_up(k_roulette_zero, winning_number)) {
		payout_chip(drop_zone_zero, rl_multiplier_for_bet_type(roulette_bet_type.straight_up));
	} else {
		payout_chip(drop_zone_zero, -1);
	}
	
	if (rl_is_straight_up(k_roulette_double_zero, winning_number)) {
		payout_chip(drop_zone_double_zero, rl_multiplier_for_bet_type(roulette_bet_type.straight_up));
	} else {
		payout_chip(drop_zone_double_zero, -1);
	}
	
	for (var i = 0; i < 36; ++i) {
		var value = value_for_dzi_straight_up(i);
		if (rl_is_straight_up(value, winning_number)) {
			payout_chip(drop_zones_straight_ups[| i], rl_multiplier_for_bet_type(roulette_bet_type.straight_up));
		} else {
			payout_chip(drop_zones_straight_ups[| i], -1);
		}
	}
	
	// Payout splits
	if (rl_is_vertical_double(k_roulette_double_zero, winning_number)) {
		payout_chip(drop_zone_zero_split, rl_multiplier_for_bet_type(roulette_bet_type.split));
	} else {
		payout_chip(drop_zone_zero_split, -1);
	}
	
	for (var i = 0; i < ds_list_size(drop_zones_splits_horizontal); ++i) {
		var value = value_for_dzi_splits_horizontal(i);
		if (rl_is_horizontal_double(value, winning_number)) {
			payout_chip(drop_zones_splits_horizontal[| i], rl_multiplier_for_bet_type(roulette_bet_type.split));
		} else {
			payout_chip(drop_zones_splits_horizontal[| i], -1);
		}
	}
	
	for (var i = 0; i < ds_list_size(drop_zones_splits_vertical); ++i) {
		var value = value_for_dzi_splits_vertical(i);
		if (rl_is_vertical_double(value, winning_number)) {
			payout_chip(drop_zones_splits_vertical[| i], rl_multiplier_for_bet_type(roulette_bet_type.split));
		} else {
			payout_chip(drop_zones_splits_vertical[| i], -1);
		}
	}
	
	// Payout corners
	for (var i = 0; i < ds_list_size(drop_zones_corners); ++i) {
		var value = value_for_dzi_corners(i);
		if (rl_is_corner(value, winning_number)) {
			payout_chip(drop_zones_corners[| i], rl_multiplier_for_bet_type(roulette_bet_type.corner));
		} else {
			payout_chip(drop_zones_corners[| i], -1);
		}
	}
	
	// Payout streets
	for (var i = 0; i < ds_list_size(drop_zones_streets); ++i) {
		if (rl_is_street(i, winning_number)) {
			payout_chip(drop_zones_streets[| i], rl_multiplier_for_bet_type(roulette_bet_type.street));
		} else {
			payout_chip(drop_zones_streets[| i], -1);
		}
	}
	
	// Payout double streets
	for (var i = 0; i < ds_list_size(drop_zones_double_streets); ++i) {
		if (rl_is_double_street(i, winning_number)) {
			payout_chip(drop_zones_double_streets[| i], rl_multiplier_for_bet_type(roulette_bet_type.double_street));
		} else {
			payout_chip(drop_zones_double_streets[| i], -1);
		}
	}
	
	// Payout columns
	for (var i = 0; i < ds_list_size(drop_zones_columns); ++i) {
		if (rl_is_column(i, winning_number)) {
			payout_chip(drop_zones_columns[| i], rl_multiplier_for_bet_type(roulette_bet_type.column));
		} else {
			payout_chip(drop_zones_columns[| i], -1);
		}
	}
	
	// Payout dozens
	for (var i = 0; i < ds_list_size(drop_zones_dozens); ++i) {
		if (rl_is_dozen(i, winning_number)) {
			payout_chip(drop_zones_dozens[| i], rl_multiplier_for_bet_type(roulette_bet_type.dozen));
		} else {
			payout_chip(drop_zones_dozens[| i], -1);
		}
	}
	
	// Payout red/black
	if (rl_is_red(winning_number)) {
		payout_chip(drop_zone_red, rl_multiplier_for_bet_type(roulette_bet_type.red));
	} else {
		payout_chip(drop_zone_red, -1);
	}
	
	if (rl_is_black(winning_number)) {
		payout_chip(drop_zone_black, rl_multiplier_for_bet_type(roulette_bet_type.black));
	} else {
		payout_chip(drop_zone_black, -1);
	}
	
	// Payout odd/even
	if (rl_is_odd(winning_number)) {
		payout_chip(drop_zone_odd, rl_multiplier_for_bet_type(roulette_bet_type.odd));
	} else {
		payout_chip(drop_zone_odd, -1);
	}
	
	if (rl_is_even(winning_number)) {
		payout_chip(drop_zone_even, rl_multiplier_for_bet_type(roulette_bet_type.even));
	} else {
		payout_chip(drop_zone_even, -1);
	}
	
	// Payout high/low
	if (rl_is_high(winning_number)) {
		payout_chip(drop_zone_high, rl_multiplier_for_bet_type(roulette_bet_type.high));
	} else {
		payout_chip(drop_zone_high, -1);
	}
	
	if (rl_is_low(winning_number)) {
		payout_chip(drop_zone_low, rl_multiplier_for_bet_type(roulette_bet_type.low));
	} else {
		payout_chip(drop_zone_low, -1);
	}
	
	// Payout three/five
	if (rl_is_three_number(winning_number)) {
		payout_chip(drop_zone_three_number, rl_multiplier_for_bet_type(roulette_bet_type.three_number));
	} else {
		payout_chip(drop_zone_three_number, -1);
	}
	
	if (rl_is_five_number(winning_number)) {
		payout_chip(drop_zone_five_number, rl_multiplier_for_bet_type(roulette_bet_type.five_number));
	} else {
		payout_chip(drop_zone_five_number, -1);
	}
	
	alarm[1] = 2 * room_speed;
}

#endregion

// Game buttons
game_button_top_left = undefined;
game_button_bottom_left = undefined;
game_button_top_right = undefined;
game_button_bottom_right = undefined;

last_number_label = undefined;

// Note: For this to work, the creation order for this object must be after all interface items
load_interface_vars_from_room();

#region Button actions

spin_action = function() {
	begin_spin();
}

double_bet_action = function() {
	
}

repeat_bet_action = function() {
	
}

clear_bets_action = function() {
	list_for_each(drop_zones_all, function(zone) {
		// TODO: Animate
		global.balance += zone.chip.value;
		zone.chip.value = 0;
	});
}

game_button_top_left.action = function() {
	repeat_bet_action();
}

game_button_bottom_left.action = function() {
	double_bet_action();
}

game_button_top_right.action = function() {
	clear_bets_action();
}

game_button_bottom_right.action = function() {
	spin_action();
}

#endregion

create_drop_zones();
begin_betting();