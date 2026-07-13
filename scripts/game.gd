extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		SceneManager.change_scene("res://scenes/Title.tscn")

func _ready() -> void:
	GameState.reset()
	$Goal.body_entered.connect(_on_goal_entered)
	$DeathArea.body_entered.connect(_on_death_entered)

func _on_goal_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Player.set_physics_process(false)
		SceneManager.change_scene("res://scenes/Title.tscn")

func _on_death_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Player.set_physics_process(false)
		SceneManager.change_scene("res://scenes/Title.tscn")
