/// @description Insert description here
// You can write your code in this editor

event_inherited();

is_hovering = false;
is_pressed = false;

left_sprite = function() {
	if (!is_enabled) {
		return spr_button_round_rect_disabled_left;
	} else if (is_pressed && is_hovering) {
		return spr_button_round_rect_pressed_left;
	} else if (is_hovering) {
		return spr_button_round_rect_hover_left;
	} else {
		return spr_button_round_rect_default_left;
	}
}

center_sprite = function() {
	if (!is_enabled) {
		return spr_button_round_rect_disabled_center;
	} else if (is_pressed && is_hovering) {
		return spr_button_round_rect_pressed_center;
	} else if (is_hovering) {
		return spr_button_round_rect_hover_center;
	} else {
		return spr_button_round_rect_default_center;
	}
}

right_sprite = function() {
	if (!is_enabled) {
		return spr_button_round_rect_disabled_right;
	} else if (is_pressed && is_hovering) {
		return spr_button_round_rect_pressed_right;
	} else if (is_hovering) {
		return spr_button_round_rect_hover_right;
	} else {
		return spr_button_round_rect_default_right;
	}
}

font = function() {
	return fnt_button;
}

font_color = function() {
	if (!is_enabled) {
		return make_color_rgb(146, 146, 146);
	} else if (is_pressed && is_hovering) {
		return make_color_rgb(146, 146, 146);
	} else if (is_hovering) {
		return c_white;
	} else {
		// Dim text when pressed but not hovering
		return is_pressed ? make_color_rgb(146, 146, 146) : c_white;
	}
}