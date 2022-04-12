/// @description Begin next sidebet
// You can write your code in this editor

switch (stage) {
case bj_game_stage_type.plus_three_payout:
	lucky_aces_begin();
	break;
case bj_game_stage_type.lucky_aces_payout:
	if (list_first(list_last(hands).card_values()).rank == rank_type.a) {
		// Up card is ace, begin insurance
		insurance_begin();
	} else {
		// Otherwise, continue on with game (paying out blackjacks is next)
		alarm[2] = 2 * room_speed;
	}
	break;
default:
	plus_three_begin();
	break;
}