/// @description Initialize game variables

// TODO: Save and load balance when quitting and loading
/// @description The player's current balance
global.balance = 500;

randomize();

room_goto(rm_main_menu);
