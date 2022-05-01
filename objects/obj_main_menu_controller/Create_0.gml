/// @description Insert description here
// You can write your code in this editor

button_blackjack = undefined;
button_roulette = undefined;
button_options = undefined;
button_quit = undefined;

load_interface_vars_from_room();

button_blackjack.action = function() {
	room_goto(rm_blackjack);
}

button_roulette.action = function() {
	room_goto(rm_roulette);
}

button_options.action = function() {
	room_goto(rm_options);
}

button_quit.action = function() {
	game_end();
}
