/// @description Initialize game variables

// TODO: Save and load balance when quitting and loading
/// @description The player's current balance
global.balance = 500;

randomize();

// TODO: Add a main menu room
room_goto(casino_1);
