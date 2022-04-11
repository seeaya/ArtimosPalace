/// @description Returns a list containing the results of mapping the given closure over the list's elements.
function list_map(list, map) {
	var mapped = ds_list_create();
	var list_size = ds_list_size(list);
	
	for (var i = 0; i < list_size; ++i) {
		ds_list_add(mapped, map(list[| i]));
	}
	
	return mapped;
}

/// @description Returns a list containing all non-undefined results of mapping the given closure over the list's elements.
function list_compact_map(list, map) {
	var mapped = ds_list_create();
	var list_size = ds_list_size(list);
	
	for (var i = 0; i < list_size; ++i) {
		var mapped_element = map(list[| i]);
		if (!is_undefined(undefined)) {
			ds_list_add(mapped, mapped_element);
		}
	}
	
	return mapped;
}

/// @description Runs the given closure on each of the list's elements.
function list_for_each(list, closure) {
	var list_size = ds_list_size(list);
	
	for (var i = 0; i < list_size; ++i) {
		closure(list[| i]);
	}
}

/// @description Reduces the given list using the given closure and initial value.
function list_reduce(list, initial_value, closure) {
	var value = initial_value;
	var list_size = ds_list_size(list);
	
	for (var i = 0; i < list_size; ++i) {
		value = closure(value, list[| i]);
	}
	
	return value;
}

/// @description Returns a list containing only the elements in the given list that satisfy the given predicate.
function list_filter(list, predicate) {
	var filtered = ds_list_create();
	var list_size = ds_list_size(list);
	
	for (var i = 0; i < list_size; ++i) {
		if (predicate(list[| i])) {
			ds_list_add(filtered, list[| i]);
		}
	}
	
	return filtered;
}

/// @description Returns the minimum element in the given list using the given closure.
function list_min(list, isLessThan) {
	if (ds_list_empty(list)) {
		return undefined;
	}
	
	var list_size = ds_list_size(list);
	var minimum = list[| 0];
	
	for (var i = 1; i < list_size; ++i) {
		if (isLessThan(list[| i], minimum)) {
			minimum = list[| i];
		}
	}
	
	return minimum;
}

/// @description Returns the maximum element in the given list using the given closure.
function list_max(list, isLessThan) {
	if (ds_list_empty(list)) {
		return undefined;
	}
	
	var list_size = ds_list_size(list);
	var maximum = list[| 0];
	
	for (var i = 1; i < list_size; ++i) {
		if (isLessThan(maximum, list[| i])) {
			maximum = list[| i];
		}
	}
	
	return maximum;
}

function list_first(list) {
	if (ds_list_size(list) == 0) {
		return undefined;
	}
	
	return list[| 0];
}

function list_last(list) {
	if (ds_list_size(list) == 0) {
		return undefined;
	}
	
	return list[| ds_list_size(list) - 1];
}