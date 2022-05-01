/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(1);
draw_set_valign(fa_top);
draw_set_halign(fa_right);
draw_set_color(c_white);
draw_set_font(fnt_score);

var text_x = obj_window_controller.window_x + obj_window_controller.window_width - 8;
var text_y = obj_window_controller.window_y + 8;

draw_text(text_x, text_y, "$" + string(global.balance));
