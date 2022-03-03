/// @description Draw card

draw_set_alpha(1);
sprite_index = face_up ? sprite_for_card(card) : spr_card_back;
draw_self();