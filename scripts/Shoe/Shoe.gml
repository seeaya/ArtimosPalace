function Shoe(deck_count) constructor {
	cards = ds_list_create();
	
	for (var i = 0; i < deck_count; ++i) {
		var deck = make_deck();
		
		for (var i = 0; i < ds_list_size(deck); ++i) {
			ds_list_add(cards, deck[| i]);
		}
	}
	
	ds_list_shuffle(cards);
}

function make_deck() {
	var deck = ds_list_create();
	
	for (var s = 0; s < array_length(global.all_suits); ++s) {
		for (var r = 0; r < array_length(global.all_ranks); ++r) {
			ds_list_add(deck, new Card(global.all_ranks[r], global.all_suits[s]));
		}
	}
	
	return deck;
}