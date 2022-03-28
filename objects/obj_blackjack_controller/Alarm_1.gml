/// @description Blackjack payouts complete
// You can write your code in this editor

// Get rid of all bets that were taken or handed out
for (var i = 0; i < ds_list_size(chips_taken); ++i) {
	instance_destroy(chips_taken[| i], true);
}

ds_list_destroy(chips_taken);
chips_taken = ds_list_create();

if (bj_is_blackjack(cards_dealer_values())) {
	// Dealer had blackjack, no more actions, start new round of betting
	begin_betting();
} else {
	// Dealer didn't have blackjack, continue to play
	play_begin();
}