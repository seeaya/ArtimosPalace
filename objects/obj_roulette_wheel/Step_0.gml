/// @description Insert description here
// You can write your code in this editor

if (obj_roulette_controller.stage == roulette_game_stage_type.wheel_spinning) {
	ac = animcurve_get(ac_roulette);
	ac_wheel = animcurve_get_channel(ac, "wheel");
	ac_ball_angle = animcurve_get_channel(ac, "ball_angle");
	ac_ball_radius = animcurve_get_channel(ac, "ball_radius");
	angle_wheel = animcurve_channel_evaluate(ac_wheel, min(time / 10.0, 1.0));
	angle_ball = animcurve_channel_evaluate(ac_ball_angle, min(time / 10.0, 1.0));
	radius_ball = animcurve_channel_evaluate(ac_ball_radius, min(time / 10.0, 1.0));
	
	image_angle = start_angle + angle_wheel * (target_angle - start_angle);
	image_angle %= 360;
	
	var ball_angle = image_angle + start_ball_angle + angle_ball * (target_ball_angle - start_ball_angle);
	ball_angle %= 360;
	
	var ball_radius = ball_outside + radius_ball * (ball_inside - ball_outside);
	
	ball_x = cos(degtorad(ball_angle)) * ball_radius;
	ball_y = -sin(degtorad(ball_angle)) * ball_radius;
	
	time += 1 / room_speed;
}
