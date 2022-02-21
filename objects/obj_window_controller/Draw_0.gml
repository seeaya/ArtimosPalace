/// @description Draw debug information

// Draw resolution and fps

draw_set_font(fnt_text);
draw_text(window_x, window_y, string(global.resolution.width) + "x" + string(global.resolution.height) + " @ " + string(fps));