extends Node2D


const BASE_STARTING_DISTANCE: int = 40

@export var LOAD_SPEED: float = 100.0
@export var THROW_SPEED: float = 1.0
@export var WALL_MAX_LENGTH = 10

var placeholder: PackedScene = preload("res://Scenes/placeholder_area.tscn")
var distance: float = 0
var final_target_pos: Vector2 = Vector2.ZERO
var bullet_size: Vector2
var wall_dictionary = {}

var _is_charging := false

@onready var line = $Line2D
@onready var ray = $RayCast2D
@onready var target_area = $TargetArea
@onready var wallArea = target_area.get_node("CollisionTargetArea").get_shape().get_size()
@onready var parent = get_parent()


func key_press():
	
	_is_charging = true
	if parent.get_position_on_keyboard().y == 0:
		distance -= BASE_STARTING_DISTANCE
	elif parent.get_position_on_keyboard().y == 1:
		distance -= BASE_STARTING_DISTANCE * 2.5
	elif parent.get_position_on_keyboard().y == 2:
		distance -= BASE_STARTING_DISTANCE * 4
		
		
	line.visible = true
	line.set_point_position(0, Vector2.ZERO)
	line.set_point_position(1, Vector2(0, distance))
	target_area.visible = true
	target_area.position = Vector2(0, distance)


func key_held(delta):
	if not _is_charging:
		return
		
	distance -= LOAD_SPEED * delta
	target_area.position.y = distance 
	line.set_point_position(1, Vector2(0, distance))


func key_released():
	if not _is_charging:
		return
	
	_is_charging = false
	
	line.visible = false
	target_area.visible = false
	final_target_pos = await get_final_position(distance)
	set_placeholder(final_target_pos)
	distance = 0
	
	_shoot()


func _shoot():
	var new_fence_bullet = parent.bullet_scene.instantiate()
	new_fence_bullet.position = position
	add_child(new_fence_bullet)
	
	var starting_scale = new_fence_bullet.scale
	var halfway_position = Vector2(final_target_pos.x * 0.5, final_target_pos.y * 0.5)

	var tween = get_tree().create_tween()
	tween.tween_property(new_fence_bullet, "position", halfway_position, THROW_SPEED * 0.5).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(new_fence_bullet, "scale", starting_scale * 1.3, THROW_SPEED * 0.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(new_fence_bullet, "position", final_target_pos, THROW_SPEED * 0.5).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(new_fence_bullet, "scale", starting_scale, THROW_SPEED * 0.5).set_ease(Tween.EASE_IN)
	tween.tween_callback(new_fence_bullet.initWall)
	


func get_final_position(dist: float) -> Vector2:
	var checkRight = true
	var amount_of_checks: int = 0
	var wall_height: float = dist
	
	ray.position = Vector2(position.x, wall_height)
	ray.set_target_position(Vector2(0, -wallArea.y))
	
	await get_tree().create_timer(0.001).timeout
	
	if ray.is_colliding():
		#TODO: it would be better to change the layout of bullet
		#and have the parent as main collider for checks
		#and the children for the functionality such as damagable wall and spikes
		if ray.get_collider().name == "AreaOfWall": #
			wall_height = ray.get_collider().get_parent().position.y
		else:
			wall_height = ray.get_collider().position.y
		
	var pos := Vector2(position.x, wall_height)
	
	while amount_of_checks <= WALL_MAX_LENGTH:
		amount_of_checks += 1
		ray.position = pos

		await get_tree().create_timer(0.001).timeout
		
		if not ray.is_colliding():
			break
		else:
			if checkRight:
				pos.x += wallArea.x * amount_of_checks
			else:
				pos.x -= wallArea.x * amount_of_checks
			checkRight = !checkRight
	return pos


func set_placeholder(pos):
	var new_placeholder = placeholder.instantiate()
	new_placeholder.get_node("CollisionPlaceholder").get_shape().set_size(wallArea)
	new_placeholder.position = pos
	new_placeholder.get_node("Timer").set_wait_time(THROW_SPEED)
	add_child(new_placeholder)
