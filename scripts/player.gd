extends CharacterBody2D

const SPEED := 200.0
const JUMP_SPEED := -300.0
const GRAVITY := 600.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED

	move_and_slide()
