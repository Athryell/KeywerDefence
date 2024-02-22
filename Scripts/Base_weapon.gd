extends Node2D
class_name BaseWeapon

const SPRITE_BASE_PATH_ACTIVE := "res://Sprites/Spritesheets Letters/"
const SPRITE_FORMAT_PATH := ".png"

@export var bulletScene: PackedScene
@export var RECHARGE_TIME: float
@export_multiline var description

@onready var bulletsContainer = get_tree().get_root().get_node("/root/Main/bullets_container")
@onready var rechargeTimer = $RechargeTimer

var weapon_letter: String
var _canShoot := true
var _target


func _ready():
	rechargeTimer.set_wait_time(RECHARGE_TIME)
	rechargeTimer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	_canShoot = true


func key_press():
	if _canShoot:
		_canShoot = false


func key_held():
	pass


func key_released():
	if not _canShoot and rechargeTimer.is_stopped():
		rechargeTimer.start()


func _shoot():
	print("Shoot not implemented for Weapon " + weapon_letter )


func get_texture():
	return load(SPRITE_BASE_PATH_ACTIVE + weapon_letter + SPRITE_FORMAT_PATH)
