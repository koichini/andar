extends CharacterBody2D

signal strength_changed(level: int)

const JUMP_SPEED := -300.0
const GRAVITY := 600.0
const STRENGTH_FACTORS := [0.6, 1.0, 1.5]

@export var impulse_speed := 250.0
@export var friction := 800.0

var strength := 2

func _physics_process(delta: float) -> void:
	_update_strength()

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var factor: float = STRENGTH_FACTORS[strength - 1]

	if Input.is_action_just_pressed("ui_left"):
		velocity.x = -impulse_speed * factor
	elif Input.is_action_just_pressed("ui_right"):
		velocity.x = impulse_speed * factor

	velocity.x = move_toward(velocity.x, 0.0, friction * delta)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED * factor

	move_and_slide()

func _update_strength() -> void:
	var selected := strength
	if Input.is_action_just_pressed("strength_1"):
		selected = 1
	elif Input.is_action_just_pressed("strength_2"):
		selected = 2
	elif Input.is_action_just_pressed("strength_3"):
		selected = 3

	if selected != strength:
		strength = selected
		strength_changed.emit(strength)
