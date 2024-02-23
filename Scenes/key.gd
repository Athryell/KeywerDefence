extends Node2D
class_name KeyScene

#@onready var key_sprite = $Key_sprite

const SPRITE_BASE_PATH_NOT_ACTIVE := "res://Sprites/Spritesheets Letters Disabled/"
const SPRITE_FORMAT_PATH := ".png"

var key_input_bind: String
var is_active: bool
var weapon

var _keyboard_coordinates := Vector2.ZERO

func set_button_bind(input_key):
	key_input_bind = input_key
	$Key_sprite.texture = load(SPRITE_BASE_PATH_NOT_ACTIVE + input_key + SPRITE_FORMAT_PATH)


func set_weapon(letter):
	var new_weapon = load("res://Scenes/Weapons/weapon_" + letter + ".tscn")
	if new_weapon:
		weapon = new_weapon.instantiate()
		weapon.weapon_letter = letter
		weapon.set_position_on_keyboard(get_keyboard_coordinates())
		$Key_sprite.texture = weapon.get_texture()
		add_child(weapon)


func remove_weapon():
	weapon = null


func _unhandled_input(event):
	if event is InputEventKey and event.as_text_keycode() == key_input_bind.to_upper():
		if event.pressed and not event.echo:
			handle_key_press()
		elif event.pressed and event.echo:
			handle_key_held()
		elif event.is_released():
			handle_key_released()


func handle_key_press():
	$Key_sprite.frame = 1
	if weapon:
		weapon.key_press()

func handle_key_held():
	if weapon:
		weapon.key_held()

func handle_key_released():
	$Key_sprite.frame = 0
	if weapon:
		weapon.key_released()

func set_keyboard_coordinates(pos_on_keyboard: Vector2) -> void:
	_keyboard_coordinates = pos_on_keyboard
	
func get_keyboard_coordinates() -> Vector2:
	return Vector2(_keyboard_coordinates)
