/// @description Returns true if the given number is an integer. Otherwise returns false.
function is_int(num) {
	return (num == floor(num));
}

/// @description Converts the given array to a list.
function array_to_list(arr) {
	var list = ds_list_create();
	
	for (var i = 0; i < array_length(arr); ++i) {
		ds_list_add(list, arr[i]);
	}
	
	return list;
}