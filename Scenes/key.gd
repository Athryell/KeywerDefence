extends Node2D
class_name KeyScene

#@onready var key_sprite = $Key_sprite

const SPRITE_BASE_PATH_NOT_ACTIVE := "res://Sprites/Spritesheets Letters Disabled/"
const SPRITE_FORMAT_PATH := ".png"

var key_input_bind: String
var is_active: bool
var weapon

func set_button_bind(input_key):
	key_input_bind = input_key
	$Key_sprite.texture = load(SPRITE_BASE_PATH_NOT_ACTIVE + input_key + SPRITE_FORMAT_PATH)
	$Key_sprite.set_hframes(3)


func set_weapon(letter):
	var new_weapon = load("res://Scenes/Weapons/Weapon_" + letter + ".tscn")
	if not new_weapon:
		return
	weapon = new_weapon.instantiate()
	$Key_sprite.texture = weapon.get_texture()
	
	add_child(weapon)


func remove_weapon():
	weapon = null


func _unhandled_input(event):
	if event is InputEventKey and event.as_text_keycode() == key_input_bind.to_upper():
		if event.pressed and not event.echo:
			handle_key_press()
		elif event.is_released():
			handle_key_released()


func handle_key_press():
	$Key_sprite.frame = 1
	if weapon:
		weapon.shoot()


func handle_key_released():
	$Key_sprite.frame = 0
