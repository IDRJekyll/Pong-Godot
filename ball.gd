extends CharacterBody2D

var starting_speed = 300.0
var speed = starting_speed
var direction = Vector2(1, 1).normalized()
var player_score = 0
var enemy_score = 0
var minimum_angle = deg_to_rad(15)

@onready var player = $"../Player"
@onready var enemy = $"../Enemy"
@onready var player_score_label = $"../UI/PlayerScore"
@onready var enemy_score_label = $"../UI/EnemyScore"
@onready var game_over_label = $"../UI/GameOver"
@onready var restart_button = $"../UI/RestartButton"
@onready var back_to_menu_button = $"../UI/BackToMenuButton"


func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	if position.y <= 20 or position.y >= 628:
		direction.y *= -1

	if position.x <= 60 and position.x >= 40:
		if position.y >= player.position.y - 50 and position.y <= player.position.y + 50:
			direction.x *= -1
	
	
	
	if direction.x < 0 and position.x <= 70 and position.x >= 50:
		if position.y >= player.position.y - 50 and position.y <= player.position.y + 50:
			var hit_position = abs(position.y - player.position.y) / 50.0
			var angle = lerp(minimum_angle, deg_to_rad(60), hit_position)
			if position.y < player.position.y:
				direction = Vector2(cos(angle), -sin(angle))
			else:
				direction = Vector2(cos(angle), sin(angle))
			speed += 25



	if direction.x > 0 and position.x >= 1082 and position.x <= 1102:
		if position.y >= enemy.position.y - 50 and position.y <= enemy.position.y + 50:
			
			var hit_position = abs(position.y - enemy.position.y) / 50.0
			var angle = lerp(minimum_angle, deg_to_rad(60), hit_position)
			
			if position.y < enemy.position.y:
				direction = Vector2(-cos(angle), -sin(angle))
			else:
				direction = Vector2(-cos(angle), sin(angle))
				
			speed += 25



	if position.x <= 0:
		enemy_score += 1
		enemy_score_label.text = str(enemy_score)
		reset_ball()
		
		if enemy_score >= 5:
			if enemy.is_two_player_mode:
				game_over_label.text = "PLAYER 2 WINS"
			else:
				game_over_label.text = "YOU LOSE"
				
			game_over_label.visible = true
			restart_button.visible = true
			back_to_menu_button.visible = true
			set_physics_process(false)
		else:
			reset_ball()

	if position.x >= 1152:
		player_score += 1
		player_score_label.text = str(player_score)
		reset_ball()
		
		if player_score >= 5:
			if enemy.is_two_player_mode:
				game_over_label.text = "PLAYER 1 WINS"
			else:
				game_over_label.text = "YOU WIN"
			game_over_label.visible = true
			restart_button.visible = true
			back_to_menu_button.visible = true
			set_physics_process(false)
		else:
			reset_ball()

func reset_ball() -> void:
	position = Vector2(576, 324)
	
	var horizontal_direction = [-1, 1].pick_random()
	var vertical_direction = [-1, 1].pick_random()
	
	direction = Vector2(horizontal_direction, vertical_direction).normalized()
	speed = starting_speed


func _on_restart_button_pressed() -> void:
	speed = starting_speed
	player_score = 0
	enemy_score = 0

	player_score_label.text = "0"
	enemy_score_label.text = "0"

	game_over_label.visible = false
	restart_button.visible = false

	position = Vector2(576, 324)
	direction = Vector2(1, 1).normalized()

	set_physics_process(true)
