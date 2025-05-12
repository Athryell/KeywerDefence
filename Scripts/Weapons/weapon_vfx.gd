extends Node

const SPRITE_BASE_PATH_ACTIVE := "res://Sprites/Spritesheets Letters/"
const SPRITE_BASE_PATH_NOT_ACTIVE := "res://Sprites/Spritesheets Letters Disabled/"
const SPRITE_FORMAT_PATH := ".png"
const CHARGE_SPRITE_COUNT = 6
const CHARGE_ANIM_PATH = preload("res://Sprites/KeycapCharge/keycap_charge_animation.png")


@onready var sprite_charge: Sprite2D  = $SpriteCharge
@onready var sprite_letter: Sprite2D = $SpriteLetter
@onready var super_shot_particles = $SuperShotParticles

func set_sprites(letter, active) -> void:
	var texture
	if active:
		texture = load(SPRITE_BASE_PATH_ACTIVE + letter + SPRITE_FORMAT_PATH)

		sprite_charge.texture = CHARGE_ANIM_PATH
		sprite_charge.set_hframes(CHARGE_SPRITE_COUNT)
		sprite_charge.frame = CHARGE_SPRITE_COUNT - 1
		
	else:
		texture = load(SPRITE_BASE_PATH_NOT_ACTIVE + letter + SPRITE_FORMAT_PATH) # TODO FIX: rename all with lower case for case sensitive platforms

		sprite_charge.texture = null

	sprite_letter.texture = texture


func get_sprite_charge_count() -> int:
	return CHARGE_SPRITE_COUNT


func increment_charge_frame() -> void:
	sprite_charge.frame += 1
	

func get_current_charge_frame() -> int:
	return sprite_charge.frame


func reset_sprite_charge() -> void:
	sprite_charge.frame = 0


func push_frame() -> void:
	sprite_letter.frame = 1


func release_frame() -> void:
	sprite_letter.frame = 0


func show_charge() -> void:
	sprite_charge.visible = true


func hide_charge() -> void:
	sprite_charge.visible = false


func emit_supershot() -> void:
	super_shot_particles.emitting = true
	#super_shot_particles.emit_particle()
