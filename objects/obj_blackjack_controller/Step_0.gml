/// @description Insert description here
// You can write your code in this editor

switch (stage) {
case bj_game_stage_type.player_turn:
	update_card_info();
	
	var cards;
	
	switch (play_index) {
	case 0:
		cards = cards_left_values();
		break;
	case 1:
		cards = cards_center_values();
		break;
	case 2:
		cards = cards_right_values();
		break;
	}
	
	game_button_top_right.is_enabled = bj_can_hit(cards);
	game_button_top_left.is_enabled = bj_can_double_down(cards);
	game_button_bottom_left.is_enabled = bj_can_split(cards);
	break;
case bj_game_stage_type.insurance_betting:
	update_card_info();
	break;
default:
	break;
}