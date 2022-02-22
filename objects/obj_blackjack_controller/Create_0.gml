/// @description Initialize game

// Shoe contains cards to be dealt. Many numbers of decks are common, but six is most common and compatible with size-bets
shoe = new Shoe(6);

// Blackjack requires dragging, so create drag controller
instance_create_layer(0, 0, "Instances", obj_drag_controller);