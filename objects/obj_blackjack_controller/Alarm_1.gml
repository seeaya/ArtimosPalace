/// @description Blackjack payouts complete
// You can write your code in this editor

// Get rid of all bets that were taken or handed out
list_for_each(chips_taken, function(chip) {
	instance_destroy(chip, true);
})

ds_list_destroy(chips_taken);
chips_taken = ds_list_create();

for (var i = 0; i < ds_list_size(hands) - 1; ++i) {
	if (bj_is_blackjack(hands[| i].card_values())) {
		// Remove hand
		instance_destroy(hands[| i], true);
		ds_list_delete(hands, i);
		
		// Update play index of remaining hands
		for (var j = i; j < ds_list_size(hands) - 1; ++j) {
			hands[| j].play_index -= 1;
		}
		
		--i;
	}
}

if (bj_is_blackjack(list_last(hands).card_values()) || ds_list_size(hands) == 1) {
	// Dealer had blackjack or everyone won blackjack, no more actions, start new round of betting
	begin_betting();
} else {
	// Dealer didn't have blackjack, continue to play
	play_begin();
}