/// @description Insert description here
// You can write your code in this editor

target_angle = 0.0;
start_angle = 0.0;
time = 0.0;

start_ball_angle = 0.0;
target_ball_angle = 0.0;

ball_outside = 921;
ball_inside = 559;

ball_x = 0;
ball_y = 0;

number_to_index = arrays_to_map(
	[k_roulette_zero, 2, 14, 35, 23, 4, 16, 33, 21, 6, 18, 31, 19, 8, 12, 29, 25, 10, 27, k_roulette_double_zero, 1, 13, 36, 24, 3, 15, 34, 22, 5, 17, 32, 20, 7, 11, 30, 26, 9, 28],
	[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37]
);

function spin(value) {
	// TODO: Fix bug with returning undefined from map
	var rand_offset = random_range(0.0, 360.0);
	
	var index = number_to_index[? value] ?? 0;
	target_angle = -(360 / 38) * index + 10 * 360 + rand_offset;
	time = 0.0;
	start_angle = image_angle;
	
	start_ball_angle = target_ball_angle % 360;
	target_ball_angle = -7200.0 + (360 / 38) * index;
}