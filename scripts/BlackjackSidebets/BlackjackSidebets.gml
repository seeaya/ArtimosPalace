enum bj_lucky_aces_win_type {
	three_diamonds,
	three_suited,
	three,
	two_diamonds,
	two_suited,
	two,
	one_diamond,
	one,
	loser,
}

function bj_la_win_multiplier(win_type) {
	switch (win_type) {
	case bj_lucky_aces_win_type.three_diamonds:
		return 10000;
	case bj_lucky_aces_win_type.three_suited:
		return 2000;
	case bj_lucky_aces_win_type.three:
		return 250;
	case bj_lucky_aces_win_type.two_diamonds:
		return 100;
	case bj_lucky_aces_win_type.two_suited:
		return 40;
	case bj_lucky_aces_win_type.two:
		return 10;
	case bj_lucky_aces_win_type.one_diamond:
		return 3;
	case bj_lucky_aces_win_type.one:
		return 1;
	case bj_lucky_aces_win_type.loser:
		return -1;
	}
}

function bj_la_win_name(win_type) {
	switch (win_type) {
	case bj_lucky_aces_win_type.three_diamonds:
		return "Three aces of diamonds";
	case bj_lucky_aces_win_type.three_suited:
		return "Three suited aces";
	case bj_lucky_aces_win_type.three:
		return "Three aces";
	case bj_lucky_aces_win_type.two_diamonds:
		return "Two aces of diamonds";
	case bj_lucky_aces_win_type.two_suited:
		return "Two suited diamonds";
	case bj_lucky_aces_win_type.two:
		return "Two diamonds";
	case bj_lucky_aces_win_type.one_diamond:
		return "One ace of diamond";
	case bj_lucky_aces_win_type.one:
		return "One ace";
	case bj_lucky_aces_win_type.loser:
		return undefined;
	}
}

function bj_la_win_type(cards) {
	if (bj_la_is_three_diamonds(cards)) {
		return bj_lucky_aces_win_type.three_diamonds;
	}
	
	if (bj_la_is_three_suited(cards)) {
		return bj_lucky_aces_win_type.three_suited;
	}
	
	if (bj_la_is_three(cards)) {
		return bj_lucky_aces_win_type.three;
	}
	
	if (bj_la_is_two_diamonds(cards)) {
		return bj_lucky_aces_win_type.two_diamonds;
	}
	
	if (bj_la_is_two_suited(cards)) {
		return bj_lucky_aces_win_type.two_suited;
	}
	
	if (bj_la_is_two(cards)) {
		return bj_lucky_aces_win_type.two;
	}
	
	if (bj_la_is_one_diamond(cards)) {
		return bj_lucky_aces_win_type.one_diamond;
	}
	
	if (bj_la_is_one(cards)) {
		return bj_lucky_aces_win_type.one;
	}
	
	return bj_lucky_aces_win_type.loser;
}

function bj_la_is_three_diamonds(cards) {
	var diamonds = list_filter(cards, function(card) {
		return card.suit == suit_type.diamonds && card.rank == rank_type.a;
	});
	
	if (ds_list_size(diamonds) == 3) {
		ds_list_destroy(diamonds);
		return true;
	}
	
	ds_list_destroy(diamonds);
	return false;
}

function bj_la_is_three_suited(cards) {
	var aces = list_filter(cards, function(card) {
		return card.suit == card.rank == rank_type.a;
	});
	
	if (ds_list_size(aces) == 3) {
		var suit_ref = {
			suit: aces[| 0].suit
		};
		
		var suited = list_filter(aces, method(suit_ref, function(card) {
			return card.suit == suit;
		}));
		
		if (ds_list_size(suited) == 3) {
			ds_list_destroy(suited);
			ds_list_destroy(aces);
			return true;
		}
		
		ds_list_destroy(suited);
		ds_list_destroy(aces);
		return false;
	}
	
	ds_list_destroy(aces);
	return false;
}

function bj_la_is_three(cards) {
	var aces = list_filter(cards, function(card) {
		return card.suit == card.rank == rank_type.a;
	});
	
	if (ds_list_size(aces) == 3) {
		ds_list_destroy(aces);
		return true;
	}
	
	ds_list_destroy(aces);
	return false;
}

function bj_la_is_two_diamonds(cards) {
	var diamonds = list_filter(cards, function(card) {
		return card.suit == suit_type.diamonds && card.rank == rank_type.a;
	});
	
	if (ds_list_size(diamonds) == 2) {
		ds_list_destroy(diamonds);
		return true;
	}
	
	ds_list_destroy(diamonds);
	return false;
}

function bj_la_is_two_suited(cards) {
	var aces = list_filter(cards, function(card) {
		return card.suit == card.rank == rank_type.a;
	});
	
	if (ds_list_size(aces) == 2) {
		var suit_ref = {
			suit: aces[| 0].suit
		};
		
		var suited = list_filter(aces, method(suit_ref, function(card) {
			return card.suit == suit;
		}));
		
		if (ds_list_size(suited) == 2) {
			ds_list_destroy(suited);
			ds_list_destroy(aces);
			return true;
		}
		
		ds_list_destroy(suited);
		ds_list_destroy(aces);
		return false;
	}
	
	ds_list_destroy(aces);
	return false;
}

function bj_la_is_two(cards) {
	var aces = list_filter(cards, function(card) {
		return card.suit == card.rank == rank_type.a;
	});
	
	if (ds_list_size(aces) == 2) {
		ds_list_destroy(aces);
		return true;
	}
	
	ds_list_destroy(aces);
	return false;
}

function bj_la_is_one_diamond(cards) {
	var diamonds = list_filter(cards, function(card) {
		return card.suit == suit_type.diamonds && card.rank == rank_type.a;
	});
	
	if (ds_list_size(diamonds) == 1) {
		ds_list_destroy(diamonds);
		return true;
	}
	
	ds_list_destroy(diamonds);
	return false;
}

function bj_la_is_one(cards) {
	var aces = list_filter(cards, function(card) {
		return card.rank == rank_type.a;
	});
	
	if (ds_list_size(aces) == 1) {
		ds_list_destroy(aces);
		return true;
	}
	
	ds_list_destroy(aces);
	return false;
}

enum bj_plus_three_win_type {
	suited_three,
	straight_flush,
	three,
	straight,
	flush,
	loser,
}

function bj_pt_win_multiplier(win_type) {
	switch (win_type) {
	case bj_plus_three_win_type.suited_three:
		return 250;
	case bj_plus_three_win_type.straight_flush:
		return 40;
	case bj_plus_three_win_type.three:
		return 30;
	case bj_plus_three_win_type.straight:
		return 10;
	case bj_plus_three_win_type.flush:
		return 5;
	case bj_plus_three_win_type.loser:
		return -1;
	}
}

function bj_pt_win_name(win_type) {
	switch (win_type) {
	case bj_plus_three_win_type.suited_three:
		return "Suited three of a kind";
	case bj_plus_three_win_type.straight_flush:
		return "Straight flush";
	case bj_plus_three_win_type.three:
		return "Three of a kind";
	case bj_plus_three_win_type.straight:
		return "Straight";
	case bj_plus_three_win_type.flush:
		return "Flush";
	case bj_plus_three_win_type.loser:
		return undefined;
	}
}

function bj_pt_win_type(cards) {
	if (bj_pt_is_suited_three(cards)) {
		return bj_plus_three_win_type.suited_three;
	}
	
	if (bj_pt_is_straight_flush(cards)) {
		return bj_plus_three_win_type.straight_flush;
	}
	
	if (bj_pt_is_three(cards)) {
		return bj_plus_three_win_type.three;
	}
	
	if (bj_pt_is_straight(cards)) {
		return bj_plus_three_win_type.straight;
	}
	
	if (bj_pt_is_flush(cards)) {
		return bj_plus_three_win_type.flush;
	}
	
	return bj_plus_three_win_type.loser;
}

function bj_pt_is_suited_three(cards) {
	return bj_pt_is_flush(cards) && bj_pt_is_three(cards);
}

function bj_pt_is_straight_flush(cards) {
	return bj_pt_is_straight(cards) && bj_pt_is_flush(cards);
}

function bj_pt_is_three(cards) {
	var rank_ref = {
		rank: cards[| 0].rank
	};
	
	var ranked = list_filter(cards, method(rank_ref, function(card) {
		return card.rank == rank;
	}));
	
	if (ds_list_size(ranked) == 3) {
		ds_list_destroy(ranked);
		return true;
	}
	
	ds_list_destroy(ranked);
	return false;
}

function bj_pt_is_straight(cards) {
	var ranks = list_map(cards, function(card) {
		return card.rank;
	});
	
	ds_list_sort(ranks, true);
	
	var without_aces = list_filter(ranks, function(rank) {
		return rank != rank_type.a;
	})
	
	ds_list_destroy(ranks);
	
	switch (ds_list_size(without_aces)) {
	case 2:
		// One ace - must be 2,3 or Q,K
		if (without_aces[| 0] == rank_type._2 && without_aces[| 1] == rank_type._3) {
			ds_list_destroy(without_aces);
			return true;
		} else if (without_aces[| 0] == rank_type.q && without_aces[| 1] == rank_type.k) {
			ds_list_destroy(without_aces);
			return true;
		}
		
		ds_list_destroy(without_aces);
		return false;
	case 3:
		// No aces - ranks must be offset each by 1
		if (without_aces[| 0] + 1 == without_aces[| 1] && without_aces[| 1] + 1 == without_aces[| 2]) {
			ds_list_destroy(without_aces);
			return true;
		}
		
		ds_list_destroy(without_aces);
		return false;
	default:
		ds_list_destroy(without_aces);
		return false;
	}
}

function bj_pt_is_flush(cards) {
	var suit_ref = {
		suit: cards[| 0].suit
	};
	
	var suited = list_filter(cards, method(suit_ref, function(card) {
		return card.suit == suit;
	}));
	
	if (ds_list_size(suited) == 3) {
		ds_list_destroy(suited);
		return true;
	}
	
	ds_list_destroy(suited);
	return false;
}
