/// @description Insert description here
// You can write your code in this editor

button_exit = undefined;

load_interface_vars_from_room();

button_exit.action = function() {
	if (room == rm_blackjack_help) {
		room_goto(rm_blackjack);
	} else {
		room_goto(rm_roulette);
	}
}
