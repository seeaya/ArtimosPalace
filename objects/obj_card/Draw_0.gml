/// @description Insert description here
// You can write your code in this editor

var card_width = 120;
var card_height = 160;



if (face_up) {
	// Draw front of card
	draw_set_color(c_white);
	draw_rectangle(x - card_width / 2, y - card_height / 2, x + card_width / 2, y + card_height / 2, false);
	
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	var text_color = card.is_red() ? c_red : c_black;
	draw_set_color(text_color);
	
	draw_set_font(fnt_card);
	draw_text(x, y, card.rank_text());
	
	draw_set_font(fnt_symbols);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_text(x - card_width / 2, y - card_height / 2, card.suit_text());
	
	draw_text_transformed(x + card_width / 2, y + card_height / 2, card.suit_text(), 1, 1, 180)
	
} else {
	// Draw back of card
	draw_set_color(c_blue);
	draw_rectangle(x - card_width / 2, y - card_height / 2, x + card_width / 2, y + card_height / 2, false);
}