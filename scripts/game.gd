extends Node2D

@onready var player: Node2D = $Player
@onready var level_root: Node2D = $LevelRoot

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		SceneManager.change_scene("res://scenes/Title.tscn")

func _ready() -> void:
	GameState.reset()
	var level := _load_level(GameState.level)
	level.get_node("Goal").body_entered.connect(_on_goal_entered)
	level.get_node("DeathArea").body_entered.connect(_on_death_entered)
	player.strength_changed.connect(_on_strength_changed)
	player.global_position = level.get_node("SpawnPoint").global_position
	_on_strength_changed(player.strength)

func _load_level(n: int) -> Node2D:
	var scene: PackedScene = load("res://scenes/levels/%02d.tscn" % n)
	var level: Node2D = scene.instantiate()
	level_root.add_child(level)
	return level

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
