/// @description 
function load_interface_vars_from_room() {
	with (all) {
		if (variable_instance_exists(self, "interface_name") && interface_name != "") {
			variable_instance_set(other, interface_name, self);
		}
	}
}