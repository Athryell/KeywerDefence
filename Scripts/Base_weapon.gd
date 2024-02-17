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
	rechargeTimer.set_wait_time(0.1)
	rechargeTimer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	_canShoot = true


func shoot():
	if _canShoot:
		_canShoot = false
		rechargeTimer.start()
		_release_bullet()


func _release_bullet():
	print("Release bullet not implemented for Weapon " + weapon_letter )


func get_texture():
	return load(SPRITE_BASE_PATH_ACTIVE + weapon_letter + SPRITE_FORMAT_PATH)


func findClosestEnemy(enemies: Array) -> Object:
	var closest_enemy = null
	var closest_distance = INF
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy
