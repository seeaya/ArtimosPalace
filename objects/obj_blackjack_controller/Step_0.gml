/// @description Insert description here
// You can write your code in this editor

if (is_betting) {
	
} else {
	hand_value_label_left.text = value_label(cards_left_values());
	hand_value_label_center.text = value_label(cards_center_values());
	hand_value_label_right.text = value_label(cards_right_values());
	hand_value_label_dealer.text = value_label(cards_dealer_values());
	
	hand_value_label_left.is_enabled = play_index == 0;
	hand_value_label_center.is_enabled = play_index == 1;
	hand_value_label_right.is_enabled = play_index == 2;
	
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
}