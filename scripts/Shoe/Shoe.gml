/// @description A shoe containing cards of the given number of decks
function Shoe(deck_count) constructor {
	/// @description the cards in the deck
	cards = ds_list_create();
	
	for (var i = 0; i < deck_count; ++i) {
		var deck = make_deck();
		
		for (var i = 0; i < ds_list_size(deck); ++i) {
			ds_list_add(cards, deck[| i]);
		}
	}
	
	// Automatically shuffle the shoe
	ds_list_shuffle(cards);
}

/// @description Creates a new 52-card deck of cards
function make_deck() {
	var deck = ds_list_create();
	
	for (var s = 0; s < ds_list_size(global.all_suits); ++s) {
		for (var r = 0; r < ds_list_size(global.all_ranks); ++r) {
			ds_list_add(deck, new Card(global.all_ranks[| r], global.all_suits[| s]));
		}
	}
	
	return deck;
}