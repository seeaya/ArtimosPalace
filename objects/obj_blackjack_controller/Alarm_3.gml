/// @description Blackjack dealer show card

list_last(hands).cards[| 1].face_up = true;

var cards = list_last(hands).card_values();
var value = list_last(bj_hand_values(cards));

if (value < 17) {
	list_last(hands).hit();
	alarm[3] = 2 * room_speed;
} else {
	alarm[4] = 2 * room_speed;
}

update_card_info();