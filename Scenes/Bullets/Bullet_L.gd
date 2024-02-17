extends BaseBullet

func _physics_process(delta):
	super(delta)
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta


func _on_area_entered(area):
	play_impact()
	queue_free()
	if area.has_method("take_damage"):
		area.take_damage(DMG)
