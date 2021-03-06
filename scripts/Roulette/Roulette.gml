enum roulette_game_stage_type {
	betting,
	wheel_spinning,
	payout,
}

enum roulette_bet_type {
	straight_up,
	split,
	corner,
	street,
	double_street,
	five_number,
	three_number,
	dozen,
	column,
	red,
	black,
	odd,
	even,
	high,
	low
}

#macro k_roulette_zero 0
#macro k_roulette_double_zero -1

function rl_is_straight_up(straight_up, result) {
	return result == straight_up;
}

function rl_is_vertical_double(top, result) {
	if (top == k_roulette_double_zero) {
		return result == k_roulette_zero || result == k_roulette_double_zero;
	}
	
	return result == top || result == top - 1;
}

function rl_is_horizontal_double(left, result) {
	if (left == k_roulette_double_zero) {
		return result == k_roulette_double_zero || result == 3;
	}
	
	if (left == k_roulette_zero) {
		return result == k_roulette_zero || result == 1;
	}
	
	return result == left || result == left + 3;
}

function rl_is_corner(top_left, result) {
	return rl_is_horizontal_double(top_left, result) || rl_is_horizontal_double(top_left - 1, result);
}

function rl_is_street(index, result) {
	var first = index * 3 + 1;
	var second = first + 1;
	var third = second + 1;
	
	return result == first || result == second || result == third;
}

function rl_is_double_street(left_index, result) {
	return rl_is_street(left_index, result) || rl_is_street(left_index + 1, result);
}

function rl_is_five_number(result) {
	return (result >= 1 && result <= 3) || result == k_roulette_double_zero || result == k_roulette_zero;
}

function rl_is_three_number(result) {
	return result == 2 || result == k_roulette_zero || result == k_roulette_double_zero;
}

function rl_is_dozen(index, result) {
	var min_val = index * 12 + 1;
	var max_val = min_val + 12;
	
	return result >= min_val && result < max_val;
}

function rl_is_column(index, result) {
	return (result - 1) % 3 == index;
}

function rl_is_zero(result) {
	return result == k_roulette_zero || result == k_roulette_double_zero;
}

function rl_is_low(result) {
	return result >= 1 && result <= 18;
}

function rl_is_high(result) {
	return result >= 19 && result <= 36;
}

function rl_is_even(result) {
	// I have no idea why it shouldn't be % 2 == 0
	return !rl_is_zero(result) && result % 2 == 1;
}

function rl_is_odd(result) {
	return !rl_is_zero(result) && !rl_is_even(result);
}

function rl_is_red(result) {
	switch (result) {
	case 1:
	case 3:
	case 5:
	case 7:
	case 9:
	case 12:
	case 14:
	case 16:
	case 18:
	case 19:
	case 21:
	case 23:
	case 25:
	case 27:
	case 30:
	case 32:
	case 34:
	case 36:
		return true;
	default:
		return false;
	}
}

function rl_is_black(result) {
	return !rl_is_zero(result) && !rl_is_red(result);
}

function rl_multiplier_for_bet_type(bet_type) {
	switch (bet_type) {
	case roulette_bet_type.straight_up:
		return 35;
	case roulette_bet_type.split:
		return 17;
	case roulette_bet_type.corner:
		return 8;
	case roulette_bet_type.street:
		return 11;
	case roulette_bet_type.double_street:
		return 5;
	case roulette_bet_type.five_number:
		return 6;
	case roulette_bet_type.three_number:
		return 11;
	case roulette_bet_type.dozen:
		return 2;
	case roulette_bet_type.column:
		return 2;
	case roulette_bet_type.red:
		return 1;
	case roulette_bet_type.black:
		return 1;
	case roulette_bet_type.odd:
		return 1;
	case roulette_bet_type.even:
		return 1;
	case roulette_bet_type.high:
		return 1;
	case roulette_bet_type.low:
		return 1;
	}
}