extends Node2D
class_name BaseWeapon

const SPRITE_BASE_PATH_ACTIVE := "res://Sprites/Spritesheets Letters/"
const SPRITE_FORMAT_PATH := ".png"

@export var weapon_letter: String
@export_multiline var description

var test_sprite_preload = preload("res://Sprites/Spritesheets Letters/I.png")

@export_category("Bullet Props")
@export var bulletScene: PackedScene
@export var bulletSpeed: float
@export var bulletImpact: Texture2D
@export var damage: int
@export var speed: float
@export var recharge_time: float


var _target: Vector2
var _canShoot: bool


func shoot():
	print("ERROR: Shoot not implemented for weapon letter " + weapon_letter )

func get_texture():
	return load(SPRITE_BASE_PATH_ACTIVE + weapon_letter + SPRITE_FORMAT_PATH)
