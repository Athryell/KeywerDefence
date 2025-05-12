extends Node

var _alphabet := ["ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
var _keycap_selected
var _key_hovering
var _alphabet_amount_for_workshop = {}
var _is_dragging_something = false
var _letters_in_workshop = {}
var _workshop: Workshop

# TODO: Crafting mechanic

func _ready():
	_workshop = get_tree().get_root().get_node("Main/Workshop")
	
	for l in GameManager.get_discovered_letters():
		add_letter_in_workshop(l)


func instantiate_dragging_keycap(letter):
	_workshop.instantiate_dragging_keycap(letter)


func add_letter_in_workshop(letter, amount_to_add:int = 1):
	if _alphabet_amount_for_workshop.has(letter):
		_alphabet_amount_for_workshop[letter] += amount_to_add
	else:
		_alphabet_amount_for_workshop[letter] = amount_to_add


func remove_letter_in_workshop(letter, amount_to_remove: int = 1):
	var letter_amount = _alphabet_amount_for_workshop[letter]
	
	letter_amount -= amount_to_remove
	
	if letter_amount == 0:
		push_error("Letter amount in workshop has gone below 0! It is ", letter_amount)


func get_letters_in_workshop() -> Dictionary:
	return _alphabet_amount_for_workshop


func set_hovering_key(k):
	_key_hovering = k


func get_hovering_key():
	return _key_hovering


func dragging_keycap(kc):
	if _is_dragging_something:
		return
	_is_dragging_something = true
	_keycap_selected = kc


func dropping_keycap(keycap):
	_is_dragging_something = false
