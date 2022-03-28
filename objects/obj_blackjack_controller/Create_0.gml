/// @description Initialize game

// Shoe contains cards to be dealt. Many numbers of decks are common, but six is most common and compatible with size-bets
shoe = new Shoe(6);

stage = bj_game_stage_type.betting;

// Blackjack requires dragging, so create drag controller
instance_create_layer(0, 0, "Instances", obj_drag_controller);

play_index = 0;
split_index = 0;

cards_left = ds_list_create();
cards_center = ds_list_create();
cards_right = ds_list_create();
cards_dealer = ds_list_create();

betting_insurance = array_to_list([false, false, false]);

chips_taken = ds_list_create();

// Card lists
cards_left_values = function() {
	return list_map(cards_left, function(card) {
		return card.card;
	})
}

cards_center_values = function() {
	return list_map(cards_center, function(card) {
		return card.card;
	})
}

cards_right_values = function() {
	return list_map(cards_right, function(card) {
		return card.card;
	})
}

cards_dealer_values = function() {
	return list_map(cards_dealer, function(card) {
		return card.card;
	})
}

last_card = function() {
	switch (play_index) {
	case 0:
		return list_last(cards_left);
	case 1:
		return list_last(cards_center);
	case 2:
		return list_last(cards_right);
	default:
		return list_last(cards_dealer);
	}
}

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
	
	if (ds_list_size(shoe.cards) <= 52) {
		delete shoe;
		shoe = new Shoe(6);
	}
	
	for (var i = ds_list_size(cards_left) - 1; i > 0; --i) {
		instance_destroy(cards_left[| i]);
		ds_list_delete(cards_left, i);
	}
	
	for (var i = ds_list_size(cards_center) - 1; i > 0; --i) {
		instance_destroy(cards_center[| i]);
		ds_list_delete(cards_center, i);
	}
	
	for (var i = ds_list_size(cards_right) - 1; i > 0; --i) {
		instance_destroy(cards_right[| i]);
		ds_list_delete(cards_right, i);
	}
	
	for (var i = ds_list_size(cards_dealer) - 1; i > 0; --i) {
		instance_destroy(cards_dealer[| i]);
		ds_list_delete(cards_dealer, i);
	}
	
	first_card_left.visible = false;
	first_card_center.visible = false;
	first_card_right.visible = false;
	first_card_dealer.visible = false;
	
	hand_value_label_left.visible = false;
	hand_value_label_center.visible = false;
	hand_value_label_right.visible = false;
	hand_value_label_dealer.visible = false;
}

game_begin = function() {
	var second_card_left = instance_create_layer(first_card_left.x + 48, first_card_left.y - 16, "Instances", obj_card);
	var second_card_center = instance_create_layer(first_card_center.x + 48, first_card_center.y - 16, "Instances", obj_card);
	var second_card_right = instance_create_layer(first_card_right.x + 48, first_card_right.y - 16, "Instances", obj_card);
	var second_card_dealer = instance_create_layer(first_card_dealer.x + 48, first_card_dealer.y - 16, "Instances", obj_card);
	
	cards_left = array_to_list([first_card_left, second_card_left]);
	cards_center = array_to_list([first_card_center, second_card_center]);
	cards_right = array_to_list([first_card_right, second_card_right]);
	cards_dealer = array_to_list([first_card_dealer, second_card_dealer]);
	
	var show_ref = {
		depth_index: 0,
		shoe: shoe
	}
	
	var show_card = method(show_ref, function(card) {
		var next_card = shoe.next_card();
		card.visible = true;
		card.card = next_card;
		card.depth = depth_index;
		depth_index -= 1;
	})
	
	list_for_each(cards_left, show_card);
	list_for_each(cards_center, show_card);
	list_for_each(cards_right, show_card);
	list_for_each(cards_dealer, show_card);
	
	cards_dealer[| 1].face_up = false;
	
	hand_value_label_left.visible = true;
	hand_value_label_center.visible = true;
	hand_value_label_right.visible = true;
	hand_value_label_dealer.visible = true;
	
	update_card_info();
	
	if (list_first(cards_dealer_values()).rank == rank_type.a) {
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
	
	if (bj_is_blackjack(cards_dealer_values())) {
		cards_dealer[| 1].face_up = true;
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
	
	if (bj_is_blackjack(cards_dealer_values())) {
		// Show dealer's down card
		cards_dealer_values()[| 1].face_up = true;
		had_blackjack = true;
		
		if (bj_is_blackjack(cards_left_values())) {
			// Left player pushes
			
		} else {
			// Left player loses
			
		}
		
		if (bj_is_blackjack(cards_center_values())) {
			// Center player pushes
		} else {
			// Center player loses
		}
		
		if (bj_is_blackjack(cards_right_values())) {
			// Right player pushes
		} else {
			// Right player loses
		}
	} else {
		if (bj_is_blackjack(cards_left_values())) {
			var chip = chip_move_from_drop_zone(main_drop_zone_left, room_width / 2, room_height + sprite_get_height(spr_chip_white) / 2);
			ds_list_add(chips_taken, chip);
			
			had_blackjack = true;
		}
		
		if (bj_is_blackjack(cards_center_values())) {
			var chip = chip_move_from_drop_zone(main_drop_zone_center, room_width / 2, room_height + sprite_get_height(spr_chip_white) / 2);
			ds_list_add(chips_taken, chip);
			
			had_blackjack = true;
		}
		
		if (bj_is_blackjack(cards_right_values())) {
			var chip = chip_move_from_drop_zone(main_drop_zone_right, room_width / 2, room_height + sprite_get_height(spr_chip_white) / 2);
			ds_list_add(chips_taken, chip);
			
			had_blackjack = true;
		}
	}
	
	if (had_blackjack) {
		// Wait two seconds to pay out blackjacks
		alarm[1] = room_speed * 2;
	} else {
		if (bj_is_blackjack(cards_dealer_values())) {
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

// UI Functions
update_card_info = function() {
	hand_value_label_left.text = value_label(cards_left_values());
	hand_value_label_center.text = value_label(cards_center_values());
	hand_value_label_right.text = value_label(cards_right_values());
	hand_value_label_dealer.text = value_label(cards_dealer_values());
	
	hand_value_label_left.is_enabled = play_index == 0;
	hand_value_label_center.is_enabled = play_index == 1;
	hand_value_label_right.is_enabled = play_index == 2;
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

// First card interface items
first_card_left = undefined;
first_card_center = undefined;
first_card_right = undefined;
first_card_dealer = undefined;

// Game buttons
game_button_top_left = undefined;
game_button_bottom_left = undefined;
game_button_top_right = undefined;
game_button_bottom_right = undefined;

// Hand value labels
hand_value_label_left = undefined;
hand_value_label_center = undefined;
hand_value_label_right = undefined;
hand_value_label_dealer = undefined;

// Note: For this to work, the creation order for this object must be after all interface items
load_interface_vars_from_room();

first_card_left.visible = false;
first_card_center.visible = false;
first_card_right.visible = false;
first_card_dealer.visible = false;

game_button_top_left.action = function() {
	switch (stage) {
	case bj_game_stage_type.betting:
		// Repeat bet
		break;
	case bj_game_stage_type.insurance_betting:
		break;
	case bj_game_stage_type.player_turn:
		// Double down
		break;
	default:
		break;
	}
}

game_button_bottom_left.action = function() {
	switch (stage) {
	case bj_game_stage_type.betting:
		// Double bet
		break;
	case bj_game_stage_type.insurance_betting:
		break;
	case bj_game_stage_type.player_turn:
		// Split
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
		// Bet on insurance
		betting_insurance[| play_index] = true;
		if (play_index == 2) {
			// Done with insurence bets, check dealer's cards next
			insurance_check_cards();
		} else {
			// No insurance, have next slot bet
			play_index += 1;
		}
		break;
	case bj_game_stage_type.player_turn:
		// Hit
		var next_card = instance_create_layer(last_card().x + 48, last_card().y - 16, "Instances", obj_card);
		next_card.depth = last_card().depth - 1;
		next_card.card = shoe.next_card();
		
		switch (play_index) {
		case 0:
			ds_list_add(cards_left, next_card);
			break
		case 1:
			ds_list_add(cards_center, next_card);
			break
		case 2:
			ds_list_add(cards_right, next_card);
			break
		}
		break;
	default:
		break;
	}
}

game_button_bottom_right.action = function() {
	switch (stage) {
	case bj_game_stage_type.betting:
		// Play
		game_begin();
		break;
	case bj_game_stage_type.insurance_betting:
		// No insurance
		if (play_index == 2) {
			// Done with insurence bets, check dealer's cards next
			insurance_check_cards();
		} else {
			// No insurance, have next slot bet
			play_index += 1;
		}
		break;
	case bj_game_stage_type.player_turn:
		// Stand
		if (play_index == 2) {
			// TODO: Play dealer's hand
			// TODO: Collect bets and award winnings
			begin_betting();
		} else {
			// Stand, have next slot bet
			play_index += 1;
		}
		break;
	default:
		break;
	}
}

value_label = function(cards) {
	var values = bj_hand_values(cards);
	
	if (bj_is_blackjack(cards)) {
		return "BJ";
	}
	
	if (ds_list_size(values) == 1) {
		return string(values[| 0]);
	}
	
	return string(values[| 0]) + "/" + string(values[| 1]);
}

begin_betting();
