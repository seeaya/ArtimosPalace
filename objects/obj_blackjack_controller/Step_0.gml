/// @description Insert description here
// You can write your code in this editor

switch (stage) {
case bj_game_stage_type.betting:
	// Check for any main bets to allow for playing
	var any_bets = list_reduce(main_drop_zones(), false, function(result, zone) {
		return (zone.chip.value > 0) || result;
	});
	
	game_button_bottom_right.is_enabled = any_bets;
	
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