extends WeaponDetectionArea

@onready var targetArea = $TargetArea_T

func _shoot():
	var enemies_in_range = area.get_overlapping_areas()
	if enemies_in_range.size() == 0:
		return
	elif enemies_in_range.size() == 1:
		_target = enemies_in_range[0]
	else:
		_target = findClosestEnemy(enemies_in_range)
	
	targetArea.global_position = _target.global_position
	targetArea.visible = true
	
	var new_bullet = bulletScene.instantiate()
	new_bullet.position = global_position
	new_bullet.look_at(_target.global_position)
	
	bulletsContainer.add_child(new_bullet)
