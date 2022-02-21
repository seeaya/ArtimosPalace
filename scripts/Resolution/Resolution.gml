/// @description A display resolution.
function Resolution(_width, _height, _aspect_ratio) constructor {
	/// @description The number of pixels horizontally.
	width = _width;
	/// @description The number of pixels vertically.
	height = _height;
	/// @description The aspect ratio of the display.
	aspect_ratio = _aspect_ratio;
}

/// @description Display aspect ratios.
enum aspect_ratio_type {
	// 16:9 width to height
	_16_9,
	// 16:10 width to height
	_16_10
}

/// @description All possible aspect_ratio_type values.
global.all_aspect_ratio_types = array_to_list([aspect_ratio_type._16_9, aspect_ratio_type._16_10]);

/// @description Returns the numeric aspect ratio as a real for the given display aspect ratio type.
function ratio_for_aspect_ratio_type(aspect_ratio) {
	switch (aspect_ratio) {
	case aspect_ratio_type._16_9:
		return 16/9;
	case aspect_ratio_type._16_10:
		return 16/10;
	default:
		show_error("Invalid argument to ratio_for_aspect_ratio_type.", true);
	}
}

/// @description Loads resolution data from the given filename. Returns the list of supported resolutions as a ds_list.
function load_supported_resolutions(filename) {
	var supported_resolutions = ds_list_create();
	var resolution_file = file_text_open_read(filename);
	
	while (!file_text_eof(resolution_file)) {
		var res_width = file_text_read_real(resolution_file);
		var res_height = file_text_read_real(resolution_file);
		var res_ar_horz = file_text_read_real(resolution_file);
		var res_ar_vert = file_text_read_real(resolution_file);
		var res_ar;
		
		var all_positive = res_width > 0 && res_height > 0 && res_ar_horz > 0 && res_ar_vert > 0;
		var all_integers = is_int(res_width) && is_int(res_height) && is_int(res_ar_horz) && is_int(res_ar_vert)
		
		if (!(all_positive && all_integers)) {
			show_error("Invalid resolution definition. Must be four positive integer components. Was resolutions.txt modified?", true);
		}
		
		if (res_ar_horz == 16 && res_ar_vert == 9) {
			res_ar = aspect_ratio_type._16_9;
		} else if (res_ar_horz == 16 && res_ar_vert == 10) {
			res_ar = aspect_ratio_type._16_10; 
		} else {
			show_error("Unsupported resolution aspect ratio ("
				+ string(res_ar_horz)
				+ ":"
				+ string(res_ar_vert)
				+ "). Only 16:9 and 16:10 aspect ratios are supported. Was resolutions.txt modified?", true);
		}
		
		var res = new Resolution(res_width, res_height, res_ar);
		
		ds_list_add(supported_resolutions, res);
	}
	
	file_text_close(resolution_file);
	
	if (ds_list_size(supported_resolutions) == 0) {
		show_error("No resolutions found. Was resolutions.txt modified or deleted?", true);
	}
	
	return supported_resolutions;
}

/// @description Determines the best resolution for the game given the user's display resolution. Returns a Resolution struct.
function determine_best_resolution(supported_resolutions) {
	var d_width = display_get_width();
	var d_height = display_get_height();
	
	var d_aspect_ratio = d_width / d_height;
	
	var ref = {
		d_aspect_ratio: d_aspect_ratio
	};
	
	var best_aspect_ratio = list_min(global.all_aspect_ratio_types, method(ref, function(lhs, rhs) {
		return abs(ratio_for_aspect_ratio_type(lhs) < d_aspect_ratio)
			< abs(ratio_for_aspect_ratio_type(rhs) < d_aspect_ratio);
	}));
	
	ref = {
		best_aspect_ratio: best_aspect_ratio,
		d_width: d_width,
		d_height: d_height
	};
	
	var resolutions_with_best_aspect_ratio = list_filter(supported_resolutions, method(ref, function(element) {
		return element.aspect_ratio == best_aspect_ratio;
	}));
	
	return list_max(resolutions_with_best_aspect_ratio, method(ref, function(lhs, rhs) {
		// Number of extra horizontal pixels in the lhs resolution than the display
		var l_error = d_width - lhs.width;
		// Number of extra horizontal pixels in the rhs resolution than the display
		var r_error = d_width - rhs.width;
		
		// Prefer resolutions that are larger than the display size
		if (l_error < 0 && r_error >= 0) {
			// Left resolution smaller than display, right is larger, prefer larger
			return false;
		} else if (r_error < 0 && l_error >= 0) {
			// Left resolution larger than dispalu, right is smaller, prefer larger
			return true;
		} else {
			// Prefer resolution closest to display resolution
			return l_error < r_error;
		}
	}));
}