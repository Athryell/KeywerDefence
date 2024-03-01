extends WeaponDetectionArea


func _shoot():
	var bullet_shooted = randi_range(3,5)
	
	for bullet in bullet_shooted:
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
		
		await get_tree().create_timer(0.05).timeout
