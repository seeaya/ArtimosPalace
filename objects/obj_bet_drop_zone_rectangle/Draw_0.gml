/// @description Insert description here
// You can write your code in this editor

if ds_list_size(highlight_x) == 0 {
	event_inherited();
} else if visible {
	for (var i = 0; i < ds_list_size(highlight_x); ++i) {
		draw_set_color(drop_highlight_color);
		draw_set_alpha(drop_highlight_alpha);
		draw_rectangle(highlight_x[| i], highlight_y[| i], highlight_x[| i] + highlight_width[| i], highlight_y[| i] + highlight_height[| i], false);
	}
}

