extends Area2D


@export var STARTING_DURABILITY: int = 5
@export var HIT_PER_SECOND:float = 2
@export var DMG = 1

@onready var spikes_area = $Spikes
@onready var timerDot = $TimerDOT
@onready var startingColor: Color = modulate

var _durability


func initWall():
	_durability = STARTING_DURABILITY
	$WallCallision.set_deferred("disabled", false)
	$Spikes/SpikeCollision.set_deferred("disabled", false)
	timerDot.set_wait_time(HIT_PER_SECOND)


func _on_timer_dot_timeout():
	var enemies_in_range = spikes_area.get_overlapping_areas()
	for enemy in enemies_in_range:
		if enemy.has_method("take_damage"):
			enemy.take_damage(DMG)


func take_damage(amount):
	var dmg_tween = create_tween()
	dmg_tween.tween_property($Icon, "modulate", Color(Color.RED), 0.1)
	dmg_tween.tween_property($Icon, "modulate", startingColor, 0.1)
	
	_durability -= amount
	
	if _durability <= 0:
		queue_free()
