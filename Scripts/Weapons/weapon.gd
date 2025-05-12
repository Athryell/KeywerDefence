extends Node2D

var weapon_resource: Resource
var is_active: bool = false

func shoot():
	weapon_resource.shoot()
