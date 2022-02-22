/// @description Draw self

// Don't draw if value is 0
if (value == 0) {
	exit;
}

// Set sprite to the largest chip value that is smaller than or equal to the chip values
sprite_index = unlabeled_sprite_for_chip_value(value);

// Draw chip sprite
draw_self();

// Draw value of chip on top of chip
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_font(fnt_chip);

// Make sure chip value matches color for the chip (some chips use white text, some use blue text)
draw_set_color(label_color_for_chip_sprite(sprite_index));
draw_set_alpha(1);
draw_text(x, y, string(value));