/// @description The suit of a card
enum suit_type {
	diamonds,
	hearts,
	clubs,
	spades
}

/// @description The rank of a card. Note: does not consider jokers
enum rank_type {
	_2,
	_3,
	_4,
	_5,
	_6,
	_7,
	_8,
	_9,
	_10,
	j,
	q,
	k,
	a
}

/// @description All possible card suits
global.all_suits = array_to_list([
	suit_type.diamonds, 
	suit_type.hearts, 
	suit_type.clubs, 
	suit_type.spades
]);

/// @description All possible card ranks
global.all_ranks = array_to_list([
	rank_type._2,
	rank_type._3,
	rank_type._4,
	rank_type._5,
	rank_type._6,
	rank_type._7,
	rank_type._8,
	rank_type._9,
	rank_type._10,
	rank_type.j,
	rank_type.q,
	rank_type.k,
	rank_type.a
])

/// @description A card containing a rank and suit
function Card(_rank, _suit) constructor {
	/// @description The rank of the card
	rank = _rank;
	
	/// @description The suit of the card
	suit = _suit;
	
	/// @description The text of the rank of the card
	rank_text = function() {
		switch (rank) {
		case rank_type._2:
			return "2";
		case rank_type._3:
			return "3";
		case rank_type._4:
			return "4";
		case rank_type._5:
			return "5";
		case rank_type._6:
			return "6";
		case rank_type._7:
			return "7";
		case rank_type._8:
			return "8";
		case rank_type._9:
			return "9";
		case rank_type._10:
			return "10";
		case rank_type.j:
			return "J";
		case rank_type.q:
			return "Q";
		case rank_type.k:
			return "K";
		case rank_type.a:
			return "A";
		}
	}
	
	/// @description The text of the suit of the card. Uses unicode characters for the suit
	suit_text = function() {
		switch (suit) {
		case suit_type.diamonds:
			return chr($2666);
		case suit_type.hearts:
			return chr($2665);
		case suit_type.spades:
			return chr($2660);
		case suit_type.clubs:
			return chr($2663);
		}
	}
	
	/// @description True if the card is a diamond or heart suit, otherwise false
	is_red = function() {
		switch (suit) {
		case suit_type.diamonds:
		case suit_type.hearts:
			return true;
		case suit_type.spades:
		case suit_type.clubs:
			return false;
		}
	}
}

/// @description The sprite of the given card
function sprite_for_card(card) {
	switch (card.suit) {
	case suit_type.diamonds:
		switch (card.rank) {
		case rank_type.a:
			return spr_card_ace_diamonds;
		case rank_type._2:
			return spr_card_2_diamonds;
		case rank_type._3:
			return spr_card_3_diamonds;
		case rank_type._4:
			return spr_card_4_diamonds;
		case rank_type._5:
			return spr_card_5_diamonds;
		case rank_type._6:
			return spr_card_6_diamonds;
		case rank_type._7:
			return spr_card_7_diamonds;
		case rank_type._8:
			return spr_card_8_diamonds;
		case rank_type._9:
			return spr_card_9_diamonds;
		case rank_type._10:
			return spr_card_10_diamonds;
		case rank_type.j:
			return spr_card_jack_diamonds;
		case rank_type.q:
			return spr_card_queen_diamonds;
		case rank_type.k:
			return spr_card_king_diamonds;
		}
	case suit_type.hearts:
		switch (card.rank) {
		case rank_type.a:
			return spr_card_ace_hearts;
		case rank_type._2:
			return spr_card_2_hearts;
		case rank_type._3:
			return spr_card_3_hearts;
		case rank_type._4:
			return spr_card_4_hearts;
		case rank_type._5:
			return spr_card_5_hearts;
		case rank_type._6:
			return spr_card_6_hearts;
		case rank_type._7:
			return spr_card_7_hearts;
		case rank_type._8:
			return spr_card_8_hearts;
		case rank_type._9:
			return spr_card_9_hearts;
		case rank_type._10:
			return spr_card_10_hearts;
		case rank_type.j:
			return spr_card_jack_hearts;
		case rank_type.q:
			return spr_card_queen_hearts;
		case rank_type.k:
			return spr_card_king_hearts;
		}
	case suit_type.clubs:
		switch (card.rank) {
		case rank_type.a:
			return spr_card_ace_clubs;
		case rank_type._2:
			return spr_card_2_clubs;
		case rank_type._3:
			return spr_card_3_clubs;
		case rank_type._4:
			return spr_card_4_clubs;
		case rank_type._5:
			return spr_card_5_clubs;
		case rank_type._6:
			return spr_card_6_clubs;
		case rank_type._7:
			return spr_card_7_clubs;
		case rank_type._8:
			return spr_card_8_clubs;
		case rank_type._9:
			return spr_card_9_clubs;
		case rank_type._10:
			return spr_card_10_clubs;
		case rank_type.j:
			return spr_card_jack_clubs;
		case rank_type.q:
			return spr_card_queen_clubs;
		case rank_type.k:
			return spr_card_king_clubs;
		}
	case suit_type.spades:
		switch (card.rank) {
		case rank_type.a:
			return spr_card_ace_spades;
		case rank_type._2:
			return spr_card_2_spades;
		case rank_type._3:
			return spr_card_3_spades;
		case rank_type._4:
			return spr_card_4_spades;
		case rank_type._5:
			return spr_card_5_spades;
		case rank_type._6:
			return spr_card_6_spades;
		case rank_type._7:
			return spr_card_7_spades;
		case rank_type._8:
			return spr_card_8_spades;
		case rank_type._9:
			return spr_card_9_spades;
		case rank_type._10:
			return spr_card_10_spades;
		case rank_type.j:
			return spr_card_jack_spades;
		case rank_type.q:
			return spr_card_queen_spades;
		case rank_type.k:
			return spr_card_king_spades;
		}
	}
}