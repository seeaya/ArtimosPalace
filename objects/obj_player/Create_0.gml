/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

view_wport[1] =  global.resolution.width;
view_hport[1] = global.resolution.height;
view_camera[1] = camera_create_view(0,0, global.resolution.width, global.resolution.height , 0, noone, -1, -1, 0, 0);
