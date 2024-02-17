extends Area2D
class_name BaseBullet

@export var DMG = 1
@export var SPEED = 50
@export var RANGE = 3200
@export var RECHARGE_TIME: float
@export var impact_sprite: Texture2D
@export var impact_particles: PackedScene

var travelled_distance = 0

func _physics_process(delta):
	print("_physics_process BASE BULLET")
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func play_impact():
	if impact_sprite:
		pass
	if impact_particles:
		pass
