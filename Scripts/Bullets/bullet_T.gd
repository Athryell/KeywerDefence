extends BaseBullet

@onready var areaAOE = $AreaAOE


func _physics_process(delta):
	super(delta)
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta


func _on_area_entered(area):
	if area.name == "TargetArea_T":
		area.visible  = false
		set_physics_process(false)
		$AnimationPlayer.play("hit_hammer")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hit_hammer":
		play_impact()
		
		#areaAOE.visible = true
		$AnimationPlayer.play("impact")
		var enemiesHit = areaAOE.get_overlapping_areas()
		for enemy in enemiesHit:
			if enemy.has_method("take_damage"):
				enemy.take_damage(DMG)
	elif anim_name == "impact":
		queue_free()
		
