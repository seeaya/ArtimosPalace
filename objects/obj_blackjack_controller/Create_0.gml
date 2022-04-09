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

betting_insurance = array_to_list([false, false, false]);

chips_taken = ds_list_create();

chips_win_dest_x = room_width / 2;
chips_win_dest_y = room_height + sprite_get_height(spr_chip_white) / 2;

chips_lose_dest_x = room_width / 2;
chips_lose_dest_y = -sprite_get_height(spr_chip_white) / 2;

// Game transition functions
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
	
	// Remove all chips previously removed
	for (var i = 0; i < ds_list_size(chips_taken); ++i) {
		instance_destroy(chips_taken[| i], true);
	}
	
	ds_list_destroy(chips_taken);
	chips_taken = ds_list_create();
	
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
			hand.play_index = i;
			hand.bet = main_drop_zones()[| i].chip;
			with main_drop_zones()[| i] {
				// Create chip over drop zone, to draw chip when there is a bet
				chip = instance_create_layer(x, y, "Instances", obj_chip);
				
				// Chips scaled by 75%
				chip.image_xscale = 0.75;
				chip.image_yscale = 0.75;
			}
		
			hand.add_initial_cards();
			ds_list_add(hands, hand);
		}
	}
	
	// Add dealer hand
	var hand = instance_create_layer(first_card_positions_x[| 3], first_card_positions_y[| 3], "Instances", obj_blackjack_hand);
	hand.play_index = 3;
	hand.is_dealer = true;
	hand.add_initial_cards();
	ds_list_add(hands, hand);
	
	if (list_first(list_last(hands).card_values()).rank == rank_type.a) {
		// Up card is ace, begin insurance
		insurance_begin();
	} else {
		// Otherwise, continue on with game (paying out blackjacks is next)
		payout_blackjacks();
	}
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
	
	betting_insurance = array_to_list([false, false, false]);
}

insurance_check_cards = function() {
	stage = bj_game_stage_type.insurance_check;
	
	game_button_top_right.is_enabled = false;
	game_button_bottom_right.is_enabled = false;
	
	if (bj_is_blackjack(list_last(hands).card_values())) {
		list_last(hands).cards[| 1].face_up = true;
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
		
		for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
			if (bj_is_blackjack(hands[| i].card_values())) {
				// Player had blackjack too - push
				// TODO: Push
			} else {
				// Player did not have blackjack - lose
				// TODO: Lose bet
			}
		}
	} else {
		// Dealer does not have blackjack
		for (var i = 0; i < ds_list_size(hands) - 2; ++i) {
			if (bj_is_blackjack(hands[| i].card_values())) {
				// Player had blackjack - win
				// TODO: Win
				
				had_blackjack = true;
			}
		}
		
		// TODO: Take insurance
	}
	
	if (had_blackjack) {
		// Wait two seconds to pay out blackjacks
		alarm[1] = room_speed * 2;
	} else {
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
	stage = bj_game_stage_type.dealer_turn;
	list_last(hands).cards[| 1].face_up = true;
	list_last(hands).update_ui();
	alarm[3] = room_speed * 2;
}

payout_begin = function() {
	var dealer_card_values = list_last(hands).card_values();
	
	for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
		var player_card_values = hands[| i].card_values();
		
		switch (bj_compare_hands(player_card_values, dealer_card_values)) {
		case bj_win_type.dealer:
			// TODO: Take bet
			break;
		case bj_win_type.player:
			// TODO: Payout
			break;
		case bj_win_type.push:
			// TODO: Push
			break;
		}
	}
	
	alarm[5] = 2 * room_speed;
}

// UI Functions
update_card_info = function() {
	list_for_each(hands, function(hand) {
		hand.update_ui();
	});
}

value_label = function(cards) {
	if (ds_list_size(cards) == 1) {
		var value = bj_card_value(cards[| 0]);
		if (value == 1) {
			return "11"
		}
		return string(value)
	}
	
	var values = bj_hand_values(cards);
	
	if (bj_is_blackjack(cards)) {
		return "BJ";
	}
	
	if (values[| 0] > 21) {
		return "Bust";
	}
	
	if (ds_list_size(values) == 1) {
		return string(values[| 0]);
	}
	
	return string(values[| 0]) + "/" + string(values[| 1]);
}

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

main_drop_zones = function() {
	return array_to_list([main_drop_zone_left, main_drop_zone_center, main_drop_zone_right]);
}

lucky_aces_drop_zones = function() {
	return array_to_list([lucky_aces_drop_zone_left, lucky_aces_drop_zone_center, lucky_aces_drop_zone_right]);
}

plus_three_drop_zones = function() {
	return array_to_list([plus_three_drop_zone_left, plus_three_drop_zone_center, plus_three_drop_zone_right]);
}

// Note: For this to work, the creation order for this object must be after all interface items
load_interface_vars_from_room();

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
	} else {
		++play_index;
	}
}

// Game actions
game_action_play = function() {
	game_begin();
}

game_action_no_insurance = function() {
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
	// TODO: Implement
}

game_action_double_bet = function() {
	// TODO: Implement
}

game_action_split = function() {
	// TODO: Implement
}

game_action_bet_insurance = function() {
	hands[| play_index].play_insurance();
}

game_action_hit = function() {
	hands[| play_index].hit();
}

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

begin_betting();
