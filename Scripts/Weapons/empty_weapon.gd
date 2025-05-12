extends Node2D

@onready var sprite = $Sprite2D


func key_press():
	sprite.frame = 1


func key_held(delta):
	pass


func key_released():
	sprite.frame = 0
