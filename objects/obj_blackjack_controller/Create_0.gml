/// @description Initialize game

// Shoe contains cards to be dealt. Many numbers of decks are common, but six is most common and compatible with size-bets
shoe = new Shoe(6);

stage = bj_game_stage_type.betting;

// Blackjack requires dragging, so create drag controller
instance_create_layer(0, 0, "Instances", obj_drag_controller);

play_index = 0;

first_card_positions_x = array_to_list([880, 1920, 2976, 1920]);
first_card_positions_y = array_to_list([800, 1088,  800,  224]);

hands = ds_list_create();

#region Payouts

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
	chip.image_xscale = 0.75;
	chip.image_yscale = 0.75;
	
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

payout_chip = function(chip, multiplier) {
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

#endregion

#region Game transition functions

begin_betting = function() {
	stage = bj_game_stage_type.betting;
	game_button_top_left.text = "Repeat";
	game_button_bottom_left.text = "Double";
	game_button_top_right.text = "";
	game_button_bottom_right.text = "Play";
	
	game_button_top_left.is_enabled = true;
	game_button_bottom_left.is_enabled = true;
	game_button_top_right.is_enabled = false;
	game_button_bottom_right.is_enabled = true;
	
	main_drop_zone_left.is_enabled = true;
	main_drop_zone_center.is_enabled = true;
	main_drop_zone_right.is_enabled = true;
	
	lucky_aces_drop_zone_left.is_enabled = true;
	lucky_aces_drop_zone_center.is_enabled = true;
	lucky_aces_drop_zone_right.is_enabled = true;
	
	plus_three_drop_zone_left.is_enabled = true;
	plus_three_drop_zone_center.is_enabled = true;
	plus_three_drop_zone_right.is_enabled = true;
	
	main_drop_zone_left.chip.draggable = true;
	main_drop_zone_center.chip.draggable = true;
	main_drop_zone_right.chip.draggable = true;
	
	lucky_aces_drop_zone_left.chip.draggable = true;
	lucky_aces_drop_zone_center.chip.draggable = true;
	lucky_aces_drop_zone_right.chip.draggable = true;
	
	plus_three_drop_zone_left.chip.draggable = true;
	plus_three_drop_zone_center.chip.draggable = true;
	plus_three_drop_zone_right.chip.draggable = true;
	
	list_for_each(hands, function(hand) {
		instance_destroy(hand);
	})
	
	ds_list_destroy(hands);
	hands = ds_list_create();
}

game_begin = function() {
	main_drop_zone_left.is_enabled = false;
	main_drop_zone_center.is_enabled = false;
	main_drop_zone_right.is_enabled = false;
	
	lucky_aces_drop_zone_left.is_enabled = false;
	lucky_aces_drop_zone_center.is_enabled = false;
	lucky_aces_drop_zone_right.is_enabled = false;
	
	plus_three_drop_zone_left.is_enabled = false;
	plus_three_drop_zone_center.is_enabled = false;
	plus_three_drop_zone_right.is_enabled = false;
	
	main_drop_zone_left.chip.draggable = false;
	main_drop_zone_center.chip.draggable = false;
	main_drop_zone_right.chip.draggable = false;
	
	lucky_aces_drop_zone_left.chip.draggable = false;
	lucky_aces_drop_zone_center.chip.draggable = false;
	lucky_aces_drop_zone_right.chip.draggable = false;
	
	plus_three_drop_zone_left.chip.draggable = false;
	plus_three_drop_zone_center.chip.draggable = false;
	plus_three_drop_zone_right.chip.draggable = false;
	
	// Add player hands
	for (var i = 0; i < 3; ++i) {
		if (main_drop_zones()[| i].chip.value > 0) {
			var hand = instance_create_layer(first_card_positions_x[| i], first_card_positions_y[| i], "Instances", obj_blackjack_hand);
			hand.play_index = ds_list_size(hands);
			hand.bet = main_drop_zones()[| i].chip;
			with main_drop_zones()[| i] {
				// Create chip over drop zone, to draw chip when there is a bet
				chip = instance_create_layer(x, y, "Instances", obj_chip);
				
				// Chips scaled by 75%
				chip.image_xscale = 0.75;
				chip.image_yscale = 0.75;
			}
			
			if (plus_three_drop_zones()[| i].chip.value > 0) {
				// Add plus three side bet to hand
				hand.plus_three_bet = plus_three_drop_zones()[| i].chip;
				with plus_three_drop_zones()[| i] {
					// Create chip over drop zone, to draw chip when there is a bet
					chip = instance_create_layer(x, y, "Instances", obj_chip);
					chip.image_xscale = 0.75;
					chip.image_yscale = 0.75;
				}
			}
			
			if (lucky_aces_drop_zones()[| i].chip.value > 0) {
				// Add lucky aces side bet to hand
				// Add plus three side bet to hand
				hand.lucky_aces_bet = lucky_aces_drop_zones()[| i].chip;
				with lucky_aces_drop_zones()[| i] {
					// Create chip over drop zone, to draw chip when there is a bet
					chip = instance_create_layer(x, y, "Instances", obj_chip);
					chip.image_xscale = 0.75;
					chip.image_yscale = 0.75;
				}
			}
		
			hand.add_initial_cards();
			ds_list_add(hands, hand);
		} else {
			// Remove side-bets (not playable without main bet)
			// TODO: Prevent this from happening in betting stage
			global.balance += plus_three_drop_zones()[| i].chip.value;
			plus_three_drop_zones()[| i].chip.value = 0;
			
			global.balance += lucky_aces_drop_zones()[| i].chip.value;
			lucky_aces_drop_zones()[| i].chip.value = 0;
		}
	}
	
	// Add dealer hand
	var hand = instance_create_layer(first_card_positions_x[| 3], first_card_positions_y[| 3], "Instances", obj_blackjack_hand);
	hand.play_index = 3;
	hand.is_dealer = true;
	hand.add_initial_cards();
	ds_list_add(hands, hand);
	
	alarm[6] = 2 * room_speed;
}

plus_three_begin = function() {
	stage = bj_game_stage_type.plus_three_payout;
	
	var plus_three_sidebets = list_filter(hands, function(hand) {
		return hand.plus_three_bet != undefined;
	});
	
	if (ds_list_size(plus_three_sidebets) == 0) {
		// No bets placed, begin lucky aces now
		lucky_aces_begin();
		return;
	}
	
	// Payout sidebets
	for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
		if (hands[| i].plus_three_bet != undefined) {
			var cards = ds_list_create()
			ds_list_add(cards, hands[| i].card_values()[| 0]);
			ds_list_add(cards, hands[| i].card_values()[| 1]);
			ds_list_add(cards, list_last(hands).card_values()[| 0]);
			
			var result = bj_pt_win_type(cards);
			var multiplier = bj_pt_win_multiplier(result);
			payout_chip(hands[| i].plus_three_bet, multiplier);
			
			ds_list_destroy(cards);
		}
	}
	
	alarm[6] = 2 * room_speed;
}

lucky_aces_begin = function() {
	stage = bj_game_stage_type.lucky_aces_payout;
	
	var lucky_aces_sidebets = list_filter(hands, function(hand) {
		return hand.lucky_aces_bet != undefined;
	});
	
	if (ds_list_size(lucky_aces_sidebets) == 0) {
		// No bets placed, begin next stage now
			if (list_first(list_last(hands).card_values()).rank == rank_type.a) {
			// Up card is ace, begin insurance
			insurance_begin();
		} else {
			// Otherwise, continue on with game (paying out blackjacks is next)
			alarm[2] = 2 * room_speed;
		}
		return;
	}
	
	// Payout sidebets
	for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
		if (hands[| i].lucky_aces_bet != undefined) {
			var cards = ds_list_create()
			ds_list_add(cards, hands[| i].card_values()[| 0]);
			ds_list_add(cards, hands[| i].card_values()[| 1]);
			ds_list_add(cards, list_last(hands).card_values()[| 0]);
			
			var result = bj_la_win_type(cards);
			var multiplier = bj_la_win_multiplier(result);
			payout_chip(hands[| i].lucky_aces_bet, multiplier);
			
			ds_list_destroy(cards);
		}
	}
	
	alarm[6] = 2 * room_speed;
}

insurance_begin = function() {
	stage = bj_game_stage_type.insurance_betting
	play_index = 0;
	
	game_button_top_left.text = "";
	game_button_bottom_left.text = "";
	game_button_top_right.text = "Insurance";
	game_button_bottom_right.text = "No Insurance";
	
	game_button_top_left.is_enabled = false;
	game_button_bottom_left.is_enabled = false;
	game_button_top_right.is_enabled = true;
	game_button_bottom_right.is_enabled = true;
}

insurance_check_cards = function() {
	stage = bj_game_stage_type.insurance_check;
	
	game_button_top_right.is_enabled = false;
	game_button_bottom_right.is_enabled = false;
	
	if (bj_is_blackjack(list_last(hands).card_values())) {
		list_last(hands).cards[| 1].face_up = true;
		update_card_info();
	}
	
	alarm[0] = room_speed * 2;
}

insurance_end = function() {
	stage = bj_game_stage_type.insurance_payout;
	alarm[2] = room_speed * 2;
}

payout_blackjacks = function() {
	stage = bj_game_stage_type.blackjack_payout;
	play_index = 0;
	game_button_top_left.text = "Double Down";
	game_button_bottom_left.text = "Split";
	game_button_top_right.text = "Hit";
	game_button_bottom_right.text = "Stand";
	
	game_button_top_left.is_enabled = false;
	game_button_bottom_left.is_enabled = false;
	game_button_top_right.is_enabled = false;
	game_button_bottom_right.is_enabled = false;
	
	var had_blackjack = false;
	
	if (bj_is_blackjack(list_last(hands).card_values())) {
		// Dealer has blackjack
		// Show dealer's down card
		list_last(hands).cards[| 1].face_up = true;
		had_blackjack = true;
		update_card_info();
		
		for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
			if (bj_is_blackjack(hands[| i].card_values())) {
				// Player had blackjack too - push
				payout_chip(hands[| i].bet, 0);
			} else {
				// Player did not have blackjack - lose
				payout_chip(hands[| i].bet, -1);
			}
			
			// Payout insurance
			if (hands[| i].insurance_bet != undefined) {
				payout_chip(hands[| i].insurance_bet, 2);
				hands[| i].insurance_bet = undefined;
			}
		}
	} else {
		// Dealer does not have blackjack
		for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
			if (bj_is_blackjack(hands[| i].card_values())) {
				// Player had blackjack - win
				payout_chip(hands[| i].bet, 1.5);
				had_blackjack = true;
			}
			
			// Lose insurance
			if (hands[| i].insurance_bet != undefined) {
				payout_chip(hands[| i].insurance_bet, -1);
				hands[| i].insurance_bet = undefined;
			}
		}
	}
	
	if (had_blackjack) {
		// Wait two seconds to pay out blackjacks
		alarm[1] = room_speed * 2;
	} else {
		// FIXME: This if-statement is always false
		if (bj_is_blackjack(list_last(hands).card_values())) {
			// Dealer had blackjack, no more actions, start new round of betting
			begin_betting();
		} else {
			// Dealer didn't have blackjack, continue to play
			play_begin();
		}
	}
}

play_begin = function() {
	stage = bj_game_stage_type.player_turn;
	
	// Can always stand
	game_button_bottom_right.is_enabled = true;
}

dealer_begin = function() {
	game_button_top_left.is_enabled = false;
	game_button_bottom_left.is_enabled = false;
	game_button_top_right.is_enabled = false;
	game_button_bottom_right.is_enabled = false;
	
	stage = bj_game_stage_type.dealer_turn;
	list_last(hands).cards[| 1].face_up = true;
	update_card_info();
	
	alarm[3] = room_speed * 2;
}

payout_begin = function() {
	var dealer_card_values = list_last(hands).card_values();
	
	for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
		var player_card_values = hands[| i].card_values();
		var multiplier;
		
		switch (bj_compare_hands(player_card_values, dealer_card_values)) {
		case bj_win_type.dealer:
			multiplier = -1;
			break;
		case bj_win_type.player:
			multiplier = 1;
			break;
		case bj_win_type.push:
			multiplier = 0;
			break;
		}
		
		payout_chip(hands[| i].bet, multiplier);
	}
	
	alarm[5] = 2 * room_speed;
}

#endregion

#region UI Functions

update_card_info = function() {
	list_for_each(hands, function(hand) {
		hand.update_ui();
	});
}

#endregion

#region Interface items

// Drop zone interface items
main_drop_zone_left = undefined;
main_drop_zone_center = undefined;
main_drop_zone_right = undefined;

lucky_aces_drop_zone_left = undefined;
lucky_aces_drop_zone_center = undefined;
lucky_aces_drop_zone_right = undefined;

plus_three_drop_zone_left = undefined;
plus_three_drop_zone_center = undefined;
plus_three_drop_zone_right = undefined;

// Game buttons
game_button_top_left = undefined;
game_button_bottom_left = undefined;
game_button_top_right = undefined;
game_button_bottom_right = undefined;

game_button_exit = undefined;

// Note: For this to work, the creation order for this object must be after all interface items
load_interface_vars_from_room();

#endregion

#region Drop zone lists

main_drop_zones = function() {
	return array_to_list([main_drop_zone_left, main_drop_zone_center, main_drop_zone_right]);
}

lucky_aces_drop_zones = function() {
	return array_to_list([lucky_aces_drop_zone_left, lucky_aces_drop_zone_center, lucky_aces_drop_zone_right]);
}

plus_three_drop_zones = function() {
	return array_to_list([plus_three_drop_zone_left, plus_three_drop_zone_center, plus_three_drop_zone_right]);
}

#endregion

#region Hand helpers

next_card = function() {
	if (ds_list_size(shoe.cards) <= 52) {
		delete shoe;
		shoe = new Shoe(6);
	}
	
	return shoe.next_card();
}

end_hand = function() {
	if (play_index == ds_list_size(hands) - 2) {
		// Dealer turn
		dealer_begin();
		++play_index;
	} else {
		++play_index;
	}
}

#endregion

#region Game actions
game_action_play = function() {
	game_begin();
}

game_action_no_insurance = function() {
	hands[| play_index].pass_insurance();
	
	if (play_index == ds_list_size(hands) - 2) {
		// Done with insurance bets, check dealer's cards next
		insurance_check_cards();
	} else {
		// No insurance, have next hand bet
		play_index += 1;
	}
}

game_action_stand = function() {
	hands[| play_index].stand();
}

game_action_repeat_bet = function() {
	// TODO: Implement
}

game_action_double_down = function() {
	hands[| play_index].double_down();
}

game_action_double_bet = function() {
	// TODO: Implement
}

game_action_split = function() {
	hands[| play_index].split();
}

game_action_bet_insurance = function() {
	hands[| play_index].play_insurance();
	
	if (play_index == ds_list_size(hands) - 2) {
		// Done with insurance bets, check dealer's cards next
		insurance_check_cards();
	} else {
		// No insurance, have next hand bet
		play_index += 1;
	}
}

game_action_hit = function() {
	hands[| play_index].hit();
}

#endregion

#region Button actions

game_button_top_left.action = function() {
	switch (stage) {
	case bj_game_stage_type.betting:
		game_action_repeat_bet();
		break;
	case bj_game_stage_type.insurance_betting:
		// Nothing
		break;
	case bj_game_stage_type.player_turn:
		game_action_double_down();
		break;
	default:
		break;
	}
}

game_button_bottom_left.action = function() {
	switch (stage) {
	case bj_game_stage_type.betting:
		game_action_double_bet();
		break;
	case bj_game_stage_type.insurance_betting:
		// Nothing
		break;
	case bj_game_stage_type.player_turn:
		game_action_split();
		break;
	default:
		break;
	}
}

game_button_top_right.action = function() {
	switch (stage) {
	case bj_game_stage_type.betting:
		// Nothing
		break;
	case bj_game_stage_type.insurance_betting:
		game_action_bet_insurance();
		break;
	case bj_game_stage_type.player_turn:
		// Hit
		game_action_hit();
		break;
	default:
		break;
	}
}

game_button_bottom_right.action = function() {
	switch (stage) {
	case bj_game_stage_type.betting:
		game_action_play();
		break;
	case bj_game_stage_type.insurance_betting:
		game_action_no_insurance();
		break;
	case bj_game_stage_type.player_turn:
		game_action_stand();
		break;
	default:
		break;
	}
}

game_button_exit.action = function() {
	room_goto(Casino1);
}

#endregion

begin_betting();
