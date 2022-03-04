/// @description
function bj_card_value(card) {
	switch (card.rank) {
	case rank_type.a:
		return 1;
	case rank_type._2:
		return 2;
	case rank_type._3:
		return 3;
	case rank_type._4:
		return 4;
	case rank_type._5:
		return 5;
	case rank_type._6:
		return 6;
	case rank_type._7:
		return 7;
	case rank_type._8:
		return 8;
	case rank_type._9:
		return 9;
	case rank_type._10:
	case rank_type.j:
	case rank_type.q:
	case rank_type.k:
		return 10;
	}
}

function bj_hand_values(cards) {
	if (bj_is_blackjack(cards)) {
		return array_to_list([21]);
	}
	
	var contains_ace = false;
	var value = 0;
	
	for (var i = 0; i < ds_list_size(cards); ++i) {
		var card = cards[| i];
		if (card.rank == rank_type.a) {
			contains_ace = true;
		}
		
		value += bj_card_value(card);
	}
	
	if (contains_ace && value + 10 <= 21) {
		return array_to_list([value, value + 10]);
	}
	
	return array_to_list([value]);
}

function bj_can_hit(cards) {
	var values = bj_hand_values(cards);
	if (ds_list_size(values) > 1) {
		return true;
	} else {
		return values[| 0] < 21;
	}
}

function bj_can_double_down(cards) {
	return (ds_list_size(cards) == 2) && bj_can_hit(cards);
}

function bj_can_split(cards) {
	return (ds_list_size(cards) == 2) && bj_card_value(cards[| 0]) == bj_card_value(cards[| 1]);
}

function bj_is_blackjack(cards) {
	var card1 = cards[| 0];
	var card2 = cards[| 1];
	
	return (bj_card_value(card1) == 10 && bj_card_value(card2) == 1) || (bj_card_value(card1) == 1 && bj_card_value(card2) == 10);
}

function bj_is_bust(cards) {
	var values = bj_hand_values(cards);
	if (ds_list_size(values) > 1) {
		return false;
	}
	
	return values[| 0] > 21;
}
