/// @description Insert description here
// You can write your code in this editor

has_split = false;
has_double_down = false;
play_index = 0;
cards = ds_list_create();
is_dealer = false;

bet = undefined;

insurance_bet = undefined;
lucky_aces_bet = undefined;
plus_three_bet = undefined;

count_label = instance_create_layer(x - 224, y, "Instances", obj_label_highlighted);

add_initial_cards = function() {
	var first = instance_create_layer(x, y, "Instances", obj_card);
	first.depth = 0;
	first.card = obj_blackjack_controller.next_card();
	first.face_up = true;
	ds_list_add(cards, first);
	
	var second = instance_create_layer(x + 48, y - 16, "Instances", obj_card);
	second.depth = first.depth - 1;
	second.card = obj_blackjack_controller.next_card();
	second.face_up = !is_dealer;
	ds_list_add(cards, second)
	
	update_ui();
}

card_values = function() {
	return list_map(cards, function(card) {
		return card.card;
	})
}

value_label = function() {
	var cards = card_values();
	
	if (!self.cards[| 1].face_up) {
		// Dealer with second card hidden
		cards = array_to_list([cards[| 0]]);
	}
	
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

update_ui = function() {
	count_label.text = value_label();
	
	switch (obj_blackjack_controller.stage) {
	case bj_game_stage_type.dealer_turn:
		count_label.is_enabled = is_dealer;
		break;
	case bj_game_stage_type.player_turn:
	case bj_game_stage_type.insurance_betting:
		count_label.is_enabled = obj_blackjack_controller.play_index == play_index;
		break;
	}
}

bet_amount = function() {
	return bet.value;
}

hit = function() {
	var last_card = list_last(cards);
	
	var next_card = instance_create_layer(last_card.x + 48, last_card.y - 16, "Instances", obj_card);
	next_card.depth = last_card.depth - 1;
	next_card.card = obj_blackjack_controller.next_card();
	
	ds_list_add(cards, next_card);
}

stand = function() {
	obj_blackjack_controller.end_hand();
}

double_down = function() {
	// TODO: Implement
	has_double_down = true;
	
	var last_card = list_last(cards);
	
	var next_card = instance_create_layer(last_card.x + 96, last_card.y - 64, "Instances", obj_card);
	next_card.depth = last_card.depth - 1;
	next_card.card = obj_blackjack_controller.next_card();
	next_card.image_angle = 90;
	
	ds_list_add(cards, next_card);
	
	// TODO: Animate bet
	global.balance -= bet.value;
	bet.value *= 2;
}

split = function() {
	// TODO: Implement
	
	has_split = true;
	
	// Remove second card from this hand
	var second_card = cards[| 1];
	ds_list_delete(cards, 1);
	
	var move_amount_x = 320;
	
	// Move this hand
	x -= move_amount_x;
	cards[| 0].x = x;
	bet.x -= move_amount_x;
	count_label.x -= move_amount_x;
	
	// Create second hand
	var second_hand = instance_create_layer(x + 2 * move_amount_x, y, "Instances", obj_blackjack_hand);
	second_hand.cards = array_to_list([second_card])
	second_hand.has_split = true;
	
	second_card.x = second_hand.x;
	second_card.y = second_hand.y;
	
	// Create second bet
	var second_bet = instance_create_layer(bet.x + 2 * move_amount_x, bet.y, "Instances", obj_chip);
	second_bet.value = bet.value;
	second_bet.image_xscale = 0.75;
	second_bet.image_yscale = 0.75;
	second_hand.bet = second_bet;
	
	// TODO: Animate this bet
	global.balance -= bet.value;
	
	// Insert new hand into hand list, and update future hands play_index
	ds_list_insert(obj_blackjack_controller.hands, play_index + 1, second_hand);
	
	for (var i = play_index + 1; i < ds_list_size(obj_blackjack_controller.hands); ++i) {
		obj_blackjack_controller.hands[| i].play_index = i;
	}
	
	// Take one new card for each hand
	hit();
	second_hand.hit();
}

can_hit = function() {
	if (has_double_down) {
		return false;
	}
	
	return list_last(bj_hand_values(card_values())) < 21;
}

can_double_down = function() {
	var has_funds = global.balance >= bet_amount();
	return ds_list_size(cards) == 2 && has_funds;
}

can_split = function() {
	var has_funds = global.balance >= bet_amount();
	var same_cards = ds_list_size(cards) == 2 && bj_card_value(card_values()[| 0]) == bj_card_value(card_values()[| 1]);
	return !has_split && has_funds && same_cards;
}

can_play_insurance = function() {
	return global.balance >= bet_amount() / 2;
}

play_insurance = function() {
	// Make bet
	insurance_bet = instance_create_layer(bet.x + 200, bet.y, "Instances", obj_chip);
	insurance_bet.value = bet.value / 2;
	insurance_bet.image_xscale = 0.75;
	insurance_bet.image_yscale = 0.75;
	
	// TODO: Animate chips
	global.balance -= insurance_bet.value;
}

pass_insurance = function() {
	// Do nothing
}