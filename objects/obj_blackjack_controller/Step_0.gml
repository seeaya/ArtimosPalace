/// @description Insert description here
// You can write your code in this editor

switch (stage) {
case bj_game_stage_type.betting:
	// Check for any main bets to allow for playing
	var any_bets = list_reduce(main_drop_zones(), false, function(result, zone) {
		return (zone.chip.value > 0) || result;
	});
	
	game_button_bottom_right.is_enabled = any_bets;
	
	// DEBUG
	if (keyboard_check_released(ord("A"))) {
		ds_list_add(shoe.cards, new Card(rank_type.a, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("2"))) {
		ds_list_add(shoe.cards, new Card(rank_type._2, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("3"))) {
		ds_list_add(shoe.cards, new Card(rank_type._3, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("4"))) {
		ds_list_add(shoe.cards, new Card(rank_type._4, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("5"))) {
		ds_list_add(shoe.cards, new Card(rank_type._5, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("6"))) {
		ds_list_add(shoe.cards, new Card(rank_type._6, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("7"))) {
		ds_list_add(shoe.cards, new Card(rank_type._7, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("8"))) {
		ds_list_add(shoe.cards, new Card(rank_type._8, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("9"))) {
		ds_list_add(shoe.cards, new Card(rank_type._9, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("J"))) {
		ds_list_add(shoe.cards, new Card(rank_type.j, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("Q"))) {
		ds_list_add(shoe.cards, new Card(rank_type.q, suit_type.diamonds));
	}
	
	if (keyboard_check_released(ord("K"))) {
		ds_list_add(shoe.cards, new Card(rank_type.k, suit_type.diamonds));
	}
	
	// TODO: Disable side-bets if no main bet
	break;
case bj_game_stage_type.player_turn:
	var hand = hands[| play_index];
	game_button_top_right.is_enabled = hand.can_hit();
	game_button_top_left.is_enabled = hand.can_double_down();
	game_button_bottom_left.is_enabled = hand.can_split();
	update_card_info();
	break;
case bj_game_stage_type.insurance_betting:
	game_button_top_right.is_enabled = hands[| play_index].can_play_insurance();
	update_card_info();
	break;
default:
	break;
}