/// @description Insert description here
// You can write your code in this editor

if (!visible) {
	exit;
}

draw_set_alpha(1);

var middle_width = sprite_width - sprite_get_width(left_sprite()) - sprite_get_width(right_sprite());

if (left_sprite() != undefined) {
	draw_sprite(left_sprite(), -1, x - middle_width / 2, y);
}

if (right_sprite() != undefined) {
	draw_sprite(right_sprite(), -1, x + middle_width / 2, y);
}

if (center_sprite() != undefined) {
	draw_sprite_ext(center_sprite(), -1, x - middle_width / 2, y, middle_width, 1, 0, c_white, 1);
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (font() != undefined) {
	draw_set_font(font());
}

if (font_color != undefined) {
	draw_set_color(font_color());
}

draw_text(x, y, text);