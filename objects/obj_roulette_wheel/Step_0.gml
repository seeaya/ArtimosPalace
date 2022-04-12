/// @description Insert description here
// You can write your code in this editor

if (image_angle > 360) {
	image_angle %= 360;
}

if (obj_roulette_controller.stage == roulette_game_stage_type.wheel_spinning) {
	image_angle += angular_velocity;
	angular_velocity -= 0.05;
	angular_velocity = max(angular_velocity, 0);
}