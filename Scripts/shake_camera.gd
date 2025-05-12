extends Camera2D

@export_range(0.1, 1, 0.05) var shake_strength: float = 0.2
@export_range(0.1, 1, 0.05) var shake_decay: float = 0.1
@export var shake_offset_max: Vector2 = Vector2(10, 10)

var current_shake_strength: float

@onready var keyboard = $"../Keyboard"

func _ready():
	position = Vector2(640, 360)

func start_shake():
	current_shake_strength = shake_strength

func _process(delta: float) -> void:
	if current_shake_strength <= 0:
		return

	current_shake_strength = max(current_shake_strength - shake_decay * delta, 0)
	update_shake()

func update_shake() -> void:
	var amount: float = current_shake_strength ** 2
	var x: float = shake_offset_max.x * amount * randf_range(-1, 1)
	var y: float = shake_offset_max.y * amount * randf_range(-1, 1)
	offset = Vector2(x, y)
