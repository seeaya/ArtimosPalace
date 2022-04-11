/// @description Insert description here
// You can write your code in this editor
if(sprite_index != spr_interact)
	draw_sprite(sprite_index, 0, x, y);
if(is_visible) {
	draw_sprite(spr_interact, 0, x, y);

	draw_set_font(fnt_button)
	draw_set_halign(fa_center)
	draw_set_valign(fa_center)
	
	if(alpha < flash_speed)
	draw_text_ext_transformed_color(x,y - 85,label_text,20,200,0.5,0.5,0, 1, 1, 1, 1, (flash_speed - alpha) / flash_speed);
	else
	draw_text_ext_transformed_color(x,y - 85,label_text,20,200,0.5,0.5,0, 1, 1, 1, 1, (alpha - flash_speed) / flash_speed);

	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}
