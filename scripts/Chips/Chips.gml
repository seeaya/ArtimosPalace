/// @description Returns the labeled version of the sprite for a given chip value
function labeled_sprite_for_chip_value(value) {
	switch (value) {
	case 1:
		return spr_chip_white;
	case 2.5:
		return spr_chip_pink;
	case 5:
		return spr_chip_red;
	case 10:
		return spr_chip_blue;
	case 25:
		return spr_chip_green;
	case 100:
		return spr_chip_black;
	case 500:
		return spr_chip_purple;
	case 1000:
		return spr_chip_yellow;
	case 5000:
		return spr_chip_orange;
	case 25000:
		return spr_chip_brown;
	default:
		return undefined;
	}
}

/// @description Returns the unlabled version of the sprite of a given bet value
function unlabeled_sprite_for_chip_value(value) {
	// Uses the largest chip sprite greater or equal to the value of the bet
	if (value >= 25000) {
		return spr_chip_brown_unlabeled;
	} else if (value >= 5000) {
		return spr_chip_orange_unlabeled;
	} else if (value >= 1000) {
		return spr_chip_yellow_unlabeled;
	} else if (value >= 500) {
		return spr_chip_purple_unlabeled;
	} else if (value >= 100) {
		return spr_chip_black_unlabeled;
	} else if (value >= 25) {
		return spr_chip_green_unlabeled;
	} else if (value >= 10) {
		return spr_chip_blue_unlabeled;
	} else if (value >= 5) {
		return spr_chip_red_unlabeled;
	} else if (value >= 2.5) {
		return spr_chip_pink_unlabeled;
	} else {
		return spr_chip_white_unlabeled;
	}
}

/// @description The value of a chip given its associated unlabeled sprite
function value_for_chip_sprite(sprite) {
	switch (sprite) {
	case spr_chip_white_unlabeled:
		return 1;
	case spr_chip_pink_unlabeled:
		return 2.5;
	case spr_chip_red_unlabeled:
		return 5;
	case spr_chip_blue_unlabeled:
		return 10;
	case spr_chip_green_unlabeled:
		return 25;
	case spr_chip_black_unlabeled:
		return 100;
	case spr_chip_purple_unlabeled:
		return 500;
	case spr_chip_yellow_unlabeled:
		return 1000;
	case spr_chip_orange_unlabeled:
		return 5000;
	case spr_chip_brown_unlabeled:
		return 25000;
	}
}

/// @description The color of the label to draw on top of a given chip sprite
function label_color_for_chip_sprite(sprite) {
	switch (sprite) {
	case spr_chip_red_unlabeled:
	case spr_chip_blue_unlabeled:
	case spr_chip_green_unlabeled:
	case spr_chip_black_unlabeled:
	case spr_chip_purple_unlabeled:
	case spr_chip_brown_unlabeled:
		return c_white;
	default:
		return make_color_rgb(0, 77, 129);
	}
}

function chip_move_from_drop_zone(drop_zone, x, y) {
	var chip_source = drop_zone.chip;
	var chip = instance_create_layer(chip_source.x, chip_source.y, "Instances", obj_chip);
	chip.depth = chip_source.depth;
	chip.image_xscale = chip_source.image_xscale;
	chip.image_yscale = chip_source.image_yscale;
	chip.value = chip_source.value;
	chip.draggable = false;
	
	chip_source.value = 0;
	
	var path = path_add();
	path_add_point(path, chip.x, chip.y, 1);
	path_add_point(path, x, y, 1);
	path_set_closed(path, false);
	
	with (chip) {
		path_start(path, 1536, path_action_stop, true);
	}
	
	return chip;
}