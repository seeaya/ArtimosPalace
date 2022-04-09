/// @description Insert description here
// You can write your code in this editor

has_split = true;
has_double_down = true;
betting_insurance = false;
play_index = 0;
cards = ds_list_create();
is_dealer = false;

bet = undefined;

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
}

split = function() {
	// TODO: Implement
}

can_hit = function() {
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

play_insurance = function() {
	// TODO: Implement
}

pass_insurance = function() {
	// TODO: Implement
}