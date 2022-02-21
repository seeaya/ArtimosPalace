/// @description Find best resolution and apply

// Load supported resolutions from file (resolutions.txt)
supported_resolutions = load_supported_resolutions("resolutions.txt");
global.resolution = determine_best_resolution(supported_resolutions);

// Use these values when drawing GUI
window_x = 0;
window_y = 0;
window_width = 0;
window_height = 0;

/// @descriptioin Applies the current resolution as defined in global.resolution
apply_resolution = function() {
	view_enabled = true;
	view_visible[0] = true;
	
	view_xport[0] = 0;
	view_yport[0] = 0;
	view_wport[0] = global.resolution.width;
	view_hport[0] = global.resolution.height;
	
	var prefered_width = round(room_height * ratio_for_aspect_ratio_type(global.resolution.aspect_ratio));
	var delta_width = room_width - prefered_width;
	
	window_x = delta_width / 2;
	window_y = 0;
	window_width = prefered_width;
	window_height = room_height;
	
	view_camera[0] = camera_create_view(window_x, window_y, window_width, window_height , 0, noone, -1, -1, 0, 0);
	
	surface_resize(application_surface, global.resolution.width, global.resolution.height);
}

// Apply initial resolution
apply_resolution();

// Keeps track of currently set resolution as an index in list of all resolutions
resolution_index = ds_list_find_index(supported_resolutions, global.resolution);