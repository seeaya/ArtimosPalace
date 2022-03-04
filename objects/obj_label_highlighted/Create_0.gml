/// @description Insert description here
// You can write your code in this editor

event_inherited();

left_sprite = function() {
	return is_enabled ? spr_label_highlighted_default_left : spr_label_highlighted_disabled_left;
}

center_sprite = function() {
	return is_enabled ? spr_label_highlighted_default_center : spr_label_highlighted_disabled_center;
}

right_sprite = function() {
	return is_enabled ? spr_label_highlighted_default_right : spr_label_highlighted_disabled_right;
}

font = function() {
	return fnt_label;
}

font_color = function() {
	return is_enabled ? c_white : make_color_rgb(146, 146, 146);
}