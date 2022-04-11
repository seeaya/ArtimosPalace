/// @description Insert description here
// You can write your code in this editor

if(instance_exists(obj_player)) {
	var interact = true;
	if(abs(obj_player.x - (x + x_offset)) > x_radius)
		interact = false;
	if(abs(obj_player.y - (y + y_offset)) > y_radius)
		interact = false;
		
	if(interact && interactable)
		is_visible = true;
	else
		is_visible = false;
}	

if(is_visible && alpha == 0) {
	alpha = flash_speed * 2;
}
if(alpha > 0) alpha -= 1;
