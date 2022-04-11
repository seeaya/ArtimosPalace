/// @description Insert description here
// You can write your code in this editor

// Roulette requires dragging, so create drag controller
instance_create_layer(0, 0, "Instances", obj_drag_controller);

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
	
	drop_zone_double_zero = create_drop_zone(zero_x, zero_y, zero_width, zero_height);
	drop_zone_zero = create_drop_zone(zero_x, zero_y + zero_height + 2 * inside_padding, zero_width, zero_height);
	
	drop_zone_zero_split = create_drop_zone(zero_x, zero_y + zero_height, zero_width, inside_padding * 2);
	
	// Straight ups
	var straight_width = inside_width - 2 * inside_padding;
	var straight_height = inside_height - 2 * inside_padding;
	
	for (var row = 0; row < 12; ++row) {
		for (var col = 2; col >= 0; --col) {
			var straight_x = inside_x + row * inside_width + inside_padding;
			var straight_y = inside_y + col * inside_height + inside_padding;
			
			var drop_zone = create_drop_zone(straight_x, straight_y, straight_width, straight_height);
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
			ds_list_add(drop_zones_splits_horizontal, drop_zone);
		}
	}
	
	// Vertical Splits
	for (var row = 0; row < 12; ++row) {
		for (var col = 2; col >= 1; --col) {
			var split_x = inside_x + row * inside_width + inside_padding;
			var split_y = inside_y - inside_padding + col * inside_height;
			
			var drop_zone = create_drop_zone(split_x, split_y, straight_width, corner_height);
			ds_list_add(drop_zones_splits_vertical, drop_zone);
		}
	}
	
	// Corners
	for (var row = 1; row < 12; ++row) {
		for (var col = 2; col >= 1; --col) {
			var corner_x = inside_x - inside_padding + row * inside_width;
			var corner_y = inside_y - inside_padding + col * inside_height;
			
			var drop_zone = create_drop_zone(corner_x, corner_y, corner_width, corner_height);
			ds_list_add(drop_zones_corners, drop_zone);
		}
	}
	
	// Streets
	var street_y = inside_y + 3 * inside_height - inside_padding;
	
	for (var row = 0; row < 12; ++row) {
		var street_x = inside_x + row * inside_width + inside_padding;
		
		var drop_zone = create_drop_zone(street_x, street_y, straight_width, corner_height);
		ds_list_add(drop_zones_streets, drop_zone);
	}
	
	// Double streets
	for (var row = 1; row < 12; ++row) {
		var street_x = inside_x - inside_padding + row * inside_width;
		
		var drop_zone = create_drop_zone(street_x, street_y, corner_width, corner_height);
		ds_list_add(drop_zones_double_streets, drop_zone);
	}
	
	// Five number bet
	var five_number_x = inside_x - inside_padding;
	var five_number_y = inside_y + 3 * inside_height - inside_padding;
	drop_zone_five_number = create_drop_zone(five_number_x, five_number_y, corner_width, corner_height);
	
	// Three number bet
	var three_number_x = five_number_x;
	var three_number_y = inside_y + 1.5 * inside_height - inside_padding;
	drop_zone_three_number = create_drop_zone(three_number_x, three_number_y, corner_width, corner_height);
	
	// Dozens
	var dozen_y = inside_y + 3 * inside_height + inside_padding;
	var dozen_width = inside_width * 4;
	var dozen_height = 220 - inside_padding;
	
	for (var i = 0; i < 3; ++i) {
		var dozen_x = inside_x + i * 4 * inside_width;
		
		var drop_zone = create_drop_zone(dozen_x, dozen_y, dozen_width, dozen_height);
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

payout_chip = function(zone, multiplier) {
	// TODO: Animate
	
	if (multiplier == -1) {
		
	} else if (multiplier == 0) {
		global.balance += win_amount;
	} else {
		var win_amount = multiplier * zone.chip.value;
		global.balance += zone.chip.value;
		global.balance += win_amount;
	}
	
	zone.chip.value = 0;
}

#region Game transition functions

begin_betting = function() {
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
	
	alarm[0] = 2 * room_speed;
}

begin_payout = function() {
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
	
	// Payout streets
	
	// Payout double streets
	
	// Payout columns
	
	// Payout doubles
	
	// Payout red/black
	
	// Payout odd/even
	
	// Payout high/low
	
	// Payout three/five
	
	
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