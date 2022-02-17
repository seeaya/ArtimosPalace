enum suit_type {
	diamonds,
	hearts,
	clubs,
	spades
}

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

global.all_suits = [
	suit_type.diamonds, 
	suit_type.hearts, 
	suit_type.clubs, 
	suit_type.spades
];

global.all_ranks = [
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
]

function Card(_rank, _suit) constructor {
	rank = _rank;
	suit = _suit;
	
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