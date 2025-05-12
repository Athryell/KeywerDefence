extends Node2D

@export var SPEED: float = 80
@export var STARTING_HEALTH: float
@export var DMG = 1
@export var ATTACK_PER_SECONDS = 1

var health: float
var isAttacking := false
var currentTarget

@onready var startingColor: Color = modulate
@onready var attackTimer = $AttackTimer
@onready var attackArea = $AttackArea

func _ready():
	health = STARTING_HEALTH
	attackTimer.set_wait_time(ATTACK_PER_SECONDS)
	
func _process(delta):
	if not isAttacking:
		_walk(delta)


func _on_attack_area_area_entered(area):
	if area.has_method("take_damage"):
		currentTarget = area
		isAttacking = true
		_attack()


func _attack():
	if currentTarget != null:
		currentTarget.take_damage(DMG)
	
	var isTargetStillAlive = attackArea.get_overlapping_areas()
	
	if isTargetStillAlive:
		attackTimer.start()
		await attackTimer.timeout
		_attack()
	else:
		isAttacking = false
		currentTarget = null


func _walk(delta):
	position += Vector2.DOWN * SPEED * delta
func take_damage(amount: float):
	var dmg_tween = create_tween()
	dmg_tween.tween_property($Sprite2D, "modulate", Color(Color.RED), 0.1)
	dmg_tween.tween_property($Sprite2D, "modulate", startingColor, 0.1)
	
	health -= amount
	
	if health <= 0:
		queue_free()



