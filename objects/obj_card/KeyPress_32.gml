/// @description Randomize card

// TODO: Remove (Here for testing purposes)
card.suit = global.all_suits[| irandom(3)];
card.rank = global.all_ranks[| irandom(12)];