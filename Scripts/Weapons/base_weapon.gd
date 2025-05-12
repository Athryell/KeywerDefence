class_name BaseWeapon
extends Node2D

const FRAME_OF_SUPERSHOT: int = 4
const BULLET_BASE_PATH: String = "res://Scenes/Bullets/bullet_"
const BULLET_FORMAT_PATH: String = ".tscn"

@export var recharge_time: float = 1.0
@export_multiline var description: String

var bullet_scene: PackedScene
var weapon_letter: String
var component

var _canShoot := true
var _can_super_shoot := false
var _position_on_keyboard: Vector2
var _countdown_interval: float
var _is_active = false

@onready var bulletsContainer = get_tree().get_root().get_node("/root/Main/BulletsContainer")
@onready var rechargeTimer: Timer = $RechargeTimer
@onready var vfx = $VFX


func _ready():
	for child in get_children():
		if child.is_in_group("Component"):
			component = child
			_is_active = true
			break

	vfx.set_sprites(weapon_letter, _is_active)
	
	if not _is_active:
		return
	
	bullet_scene = load(BULLET_BASE_PATH + weapon_letter.to_lower() + BULLET_FORMAT_PATH)
	
	_countdown_interval = recharge_time / vfx.CHARGE_SPRITE_COUNT
	rechargeTimer.set_wait_time(_countdown_interval)
	rechargeTimer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	vfx.increment_charge_frame()
	var current_frame = vfx.get_current_charge_frame()
	
	_can_super_shoot = current_frame == FRAME_OF_SUPERSHOT

	if current_frame >= FRAME_OF_SUPERSHOT:
		_canShoot = true
		#TODO set fixed time for window for perfect shoot
	if current_frame < vfx.CHARGE_SPRITE_COUNT - 1:
		rechargeTimer.start(_countdown_interval)


func key_press():
	vfx.push_frame()
	
	if not _is_active:
		return
	
	if component and component.has_method("key_press"):
		component.key_press()
	vfx.hide_charge()
	
	if not _canShoot:
		return
	
	if _can_super_shoot:
		vfx.emit_supershot()
		#TODO ShakeCamera.start_shake() # KACK, use signal not singleton...
	
	_canShoot = false
	rechargeTimer.start(_countdown_interval)
	vfx.reset_sprite_charge()


func key_held(delta):
	if component and component.has_method("key_held"):
		component.key_held(delta)


func key_released():
	if component and component.has_method("key_released"):
		component.key_released()
	
	vfx.release_frame()
	vfx.show_charge()

	if not _canShoot and rechargeTimer.is_stopped():
		rechargeTimer.start()


func set_position_on_keyboard(pos: Vector2) -> void:
	_position_on_keyboard = pos
	
func get_position_on_keyboard() -> Vector2:
	return _position_on_keyboard


