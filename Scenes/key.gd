extends Node2D
class_name KeyScene

const SPRITE_BASE_PATH_ACTIVE := "res://Sprites/Spritesheets Letters/"
const SPRITE_BASE_PATH_NOT_ACTIVE := "res://Sprites/Spritesheets Letters Disabled/"
const SPRITE_FORMAT_PATH := ".png"


var key_bind: String
var override_key: String
var weapon: Resource

@onready var sprite := $Weapon/Sprite2D

func _ready():
	set_key(key_bind)


func set_key(letter):
	override_key = letter
	set_sprite(override_key)
	set_weapon(override_key)

func set_weapon(letter):
	$Weapon.weapon_resource = WeaponDatabase.get_weapon(letter)
	


func _unhandled_input(event):
	if event is InputEventKey and event.as_text_keycode() == key_bind.to_upper():
		if event.pressed and not event.echo:
			handle_key_press()
		elif event.is_released():
			handle_key_released()


func handle_key_press():
	sprite.frame = 1
	$Weapon.shoot()


func handle_key_released():
	sprite.frame = 0

var is_active

func set_sprite(key):
	var base_path
	if is_active:
		base_path = SPRITE_BASE_PATH_ACTIVE
	else:
		base_path = SPRITE_BASE_PATH_NOT_ACTIVE
		
	var sprite_path = base_path + key + SPRITE_FORMAT_PATH
	sprite.texture = load(sprite_path)

