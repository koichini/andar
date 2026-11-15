extends Node2D

@onready var player: Node2D = $Player
@onready var spawn_point: Marker2D = $Level/SpawnPoint

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		SceneManager.change_scene("res://scenes/Title.tscn")

func _ready() -> void:
	GameState.reset()
	$Level/Goal.body_entered.connect(_on_goal_entered)
	$Level/DeathArea.body_entered.connect(_on_death_entered)
	player.strength_changed.connect(_on_strength_changed)
	player.global_position = spawn_point.global_position
	_on_strength_changed(player.strength)

func _on_goal_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.set_physics_process(false)
		SceneManager.change_scene("res://scenes/Title.tscn")

func _on_death_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.set_physics_process(false)
		SceneManager.change_scene("res://scenes/Title.tscn")

func _on_strength_changed(level: int) -> void:
	$HUD/StrengthLabel.text = "Strength: %d" % level
