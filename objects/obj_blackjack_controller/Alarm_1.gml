/// @description Blackjack payouts complete
// You can write your code in this editor

// Get rid of all bets that were taken or handed out
list_for_each(chips_taken, function(chip) {
	instance_destroy(chip, true);
})

ds_list_destroy(chips_taken);
chips_taken = ds_list_create();

if (bj_is_blackjack(list_last(hands).card_values())) {
	// Dealer had blackjack, no more actions, start new round of betting
	begin_betting();
} else {
	// Dealer didn't have blackjack, continue to play
	play_begin();
}