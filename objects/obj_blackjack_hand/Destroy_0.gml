/// @description Insert description here
// You can write your code in this editor

list_for_each(cards, function(card) {
	instance_destroy(card, true);
})

ds_list_destroy(cards);

instance_destroy(count_label);

if (!is_dealer) {
	instance_destroy(bet);
}