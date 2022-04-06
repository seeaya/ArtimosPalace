/// @description Blackjack dealer show card

var cards = cards_dealer_values();
var value = list_last(bj_hand_values(cards));

if (value < 17) {
	var next_card = instance_create_layer(last_card().x + 48, last_card().y - 16, "Instances", obj_card);
	next_card.depth = last_card().depth - 1;
	next_card.card = shoe.next_card();
	ds_list_add(cards_dealer, next_card);
	update_card_info();
	alarm[3] = 2 * room_speed;
} else {
	alarm[4] = 2 * room_speed;
}

update_card_info();