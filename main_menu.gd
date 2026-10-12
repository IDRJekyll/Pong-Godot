
extends Control

@onready var player = $"../../Player"
@onready var enemy = $"../../Enemy"
@onready var ball = $"../../Ball"
@onready var player_score = $"../PlayerScore"
@onready var enemy_score = $"../EnemyScore"
@onready var game_over = $"../GameOver"
@onready var restart_button = $"../RestartButton"
@onready var back_to_menu_button = $"../BackToMenuButton"

func _ready() -> void:
	visible = true
	ball.set_physics_process(false)
	player.set_physics_process(false)
	enemy.set_physics_process(false)

func _on_vs_ai_button_pressed() -> void:
	start_game(false)

func _on_two_players_button_pressed() -> void:
	start_game(true)

func start_game(two_player_mode: bool) -> void:
	enemy.is_two_player_mode = two_player_mode

	player_score.text = "0"
	enemy_score.text = "0"
	game_over.visible = false
	restart_button.visible = false
	back_to_menu_button.visible = false

	ball.player_score = 0
	ball.enemy_score = 0
	ball.reset_ball()

	visible = false
	player.set_physics_process(true)
	enemy.set_physics_process(true)
	ball.set_physics_process(true)


func _on_back_to_menu_button_pressed() -> void:
	ball.set_physics_process(false)
	player.set_physics_process(false)
	enemy.set_physics_process(false)

	ball.player_score = 0
	ball.enemy_score = 0
	ball.reset_ball()

	player_score.text = "0"
	enemy_score.text = "0"

	game_over.visible = false
	restart_button.visible = false
	back_to_menu_button.visible = false

	visible = true


func _on_exit_button_pressed() -> void:
	get_tree().quit()
