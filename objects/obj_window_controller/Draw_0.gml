/// @description Draw debug information

// Draw resolution and fps

draw_set_alpha(1);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(fnt_text);
draw_text(window_x, window_y, string(global.resolution.width) + "x" + string(global.resolution.height) + " @ " + string(fps));