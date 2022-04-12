// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function person_collide(dir_x, dir_y, spd){
	var x_speed = spd;
	var y_speed = spd;
	while(true) {
		var y_collide = false;
		if(!place_free(x, dir_y * y_speed + y)) y_collide = true;
		if y_collide
			y_speed /= 2;
		else
			break;
			
		if(y_speed < 0.1) {
			y_speed = 0;
			break;
		}
	}
	
	while(true) {
		var x_collide = false;
		if(!place_free(dir_x * x_speed + x, y)) x_collide = true;
		if x_collide
			x_speed /= 2;
		else
			break;
			
		if(x_speed < 0.1) {
			x_speed = 0;
			break;
		}
	}
		
	return [x_speed, y_speed];
}