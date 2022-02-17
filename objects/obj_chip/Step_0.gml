/// @description Insert description here
// You can write your code in this editor

var dist = point_distance(x, y, mouse_x, mouse_y);
var radius = sprite_height / 2;

if (mouse_check_button_pressed(mb_left) && dist <= radius) {
	obj_drag_controller.begin_drag_of_item(self);
}

if (obj_drag_controller.is_dragging && obj_drag_controller.drag_item == self) {
	image_alpha = 0.5;
} else {
	image_alpha = 1;
}