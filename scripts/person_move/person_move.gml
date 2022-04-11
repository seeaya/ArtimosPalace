// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function person_move_spr(move_spr) {
	switch(move_spr) {
		case 0:
			return spr_up_left_index
		case 1:
			return spr_up_index
		case 2:
			return spr_up_right_index
		case 3:
			return spr_left_index
		case 4:
			return spr_idle_index
		case 5:
			return spr_right_index
		case 6:
			return spr_down_left_index
		case 7:
			return spr_down_index
		case 8:
			return spr_down_right_index
		default:
			return spr_idle_index
	}
}

function person_move(dir_x, dir_y, spd_x, spd_y){
	if(abs(dir_x) > 0 && abs(dir_y) > 0) {
		spd_x /= sqrt(2);
		spd_y /= sqrt(2);
	}
	y += dir_y * spd_y;
	x += dir_x * spd_x;
	
	var move_spr = (dir_x + 1) + (dir_y + 1)*3;
	sprite_index = person_move_spr(move_spr)

}