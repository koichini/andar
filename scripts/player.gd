extends CharacterBody2D

const JUMP_SPEED := -300.0
const GRAVITY := 600.0

@export var impulse_speed := 250.0
@export var friction := 800.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_left"):
		velocity.x = -impulse_speed
	elif Input.is_action_just_pressed("ui_right"):
		velocity.x = impulse_speed

	velocity.x = move_toward(velocity.x, 0.0, friction * delta)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED

	move_and_slide()
