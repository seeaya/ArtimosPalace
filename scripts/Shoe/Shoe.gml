/// @description A shoe containing cards of the given number of decks
function Shoe(deck_count) constructor {
	/// @description the cards in the deck
	cards = ds_list_create();
	
	for (var i = 0; i < deck_count; ++i) {
		var deck = make_deck();
		
		for (var j = 0; j < ds_list_size(deck); ++j) {
			ds_list_add(cards, deck[| j]);
		}
		
		ds_list_destroy(deck);
	}
	
	// Automatically shuffle the shoe
	ds_list_shuffle(cards);
	
	next_card = function() {
		var card = cards[| ds_list_size(cards) - 1];
		ds_list_delete(cards, ds_list_size(cards) - 1);
		return card;
	}
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