/// @description Insert description here
// You can write your code in this editor
var left = bool(keyboard_check(vk_left)) || bool(keyboard_check(ord("A")))
var right = bool(keyboard_check(vk_right)) || bool(keyboard_check(ord("D")))

var up = bool(keyboard_check(vk_up)) || bool(keyboard_check(ord("W")))
var down = bool(keyboard_check(vk_down)) || bool(keyboard_check(ord("S")))

var x_axis = right - left;
var y_axis = down - up;

var running = keyboard_check(vk_shift)

move_speed = running ? running_speed : walking_speed;
move_speed = person_collide(x_axis, y_axis, move_speed);
person_move(x_axis, y_axis, move_speed[0], move_speed[1]);

camera_width = camera_get_view_width(view_camera[1])
camera_height = camera_get_view_height(view_camera[1])
cam_x = x - camera_width/2;
cam_y = y - camera_height/2;
if(cam_x < 0)
	cam_x = 0;
if(cam_x > room_width - camera_width)
	cam_x = room_width - camera_width;	
	
if(cam_y < 0)
	cam_y = 0;
if(cam_y > room_height - camera_height)
	cam_y = room_height - camera_height;
	
camera_set_view_pos(view_camera[1], cam_x, cam_y);
