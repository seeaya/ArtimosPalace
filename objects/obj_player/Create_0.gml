/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if(!variable_global_exists("playerX"))
	global.playerX = x;
else
	x = global.playerX
	
if(!variable_global_exists("playerY"))
	global.playerY = y;
else
	y = global.playerY

view_wport[1] =  global.resolution.width;
view_hport[1] = global.resolution.height;
//view_camera[1] = camera_create_view(0,0, global.resolution.width, global.resolution.height , 0, noone, -1, -1, 0, 0);
