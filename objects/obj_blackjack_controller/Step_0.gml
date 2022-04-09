/// @description Insert description here
// You can write your code in this editor

switch (stage) {
case bj_game_stage_type.player_turn:
	var hand = hands[| play_index];
	game_button_top_right.is_enabled = hand.can_hit();
	game_button_top_left.is_enabled = hand.can_double_down();
	game_button_bottom_left.is_enabled = hand.can_split();
	update_card_info();
	break;
case bj_game_stage_type.insurance_betting:
	update_card_info();
	break;
default:
	break;
}