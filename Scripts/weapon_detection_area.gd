extends BaseWeapon
class_name WeaponDetectionArea

@onready var area = $DetectionArea


func _release_bullet():
	var enemies_in_range = area.get_overlapping_areas()
	if enemies_in_range.size() == 0:
		return
	elif enemies_in_range.size() == 1:
		_target = enemies_in_range[0]
	else:
		_target = findClosestEnemy(enemies_in_range)
		
	var new_bullet = bulletScene.instantiate()
	new_bullet.position = global_position
	new_bullet.look_at(_target.global_position)
	
	bulletsContainer.add_child(new_bullet)
