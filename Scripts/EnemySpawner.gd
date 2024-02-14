extends Node

const enemy := preload("res://Scenes/Characters/Enemies/base_enemy.tscn")
	
func _on_timer_timeout():
	var new_enemy = enemy.instantiate()
	new_enemy.position = Vector2(randi_range(0, get_viewport().size.x), +10)
	add_child(new_enemy)
