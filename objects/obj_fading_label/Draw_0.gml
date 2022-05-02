/// @description Insert description here
// You can write your code in this editor

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

target_alpha = min(1, (4 - time) / 2);

draw_set_font(fnt_win_label);

width = string_width(text) + 40;
height = string_height(text);
draw_set_color(make_color_rgb(24, 24, 24));
draw_set_alpha(target_alpha * 2/3);
draw_roundrect_ext(x - width / 2, y - height / 2, x + width / 2, y + height / 2, 24, 24, false);

draw_set_alpha(target_alpha);
draw_set_color(color);
draw_text(x, y, text);

