extends CharacterBody2D

var speed = 400.0
var reaction_timer = 0.0
var target_y = 300.0
var is_two_player_mode = false

@onready var ball = $"../Ball"



func _physics_process(delta: float) -> void:
	if is_two_player_mode:
		var direction = Input.get_axis("p2_up", "p2_down")
		velocity.y = direction * speed
	else:
		reaction_timer -= delta

		if reaction_timer <= 0:
			target_y = ball.position.y
			reaction_timer = 0.05

		if ball.direction.x > 0:
			if target_y < position.y - 10:
				velocity.y = move_toward(velocity.y, -speed, 50)
			elif target_y > position.y + 10:
				velocity.y = move_toward(velocity.y, speed, 50)
			else:
				velocity.y = move_toward(velocity.y, 0, 50)
		else:
			if position.y < 314:
				velocity.y = move_toward(velocity.y, speed, 50)
			elif position.y > 334:
				velocity.y = move_toward(velocity.y, -speed, 50)
			else:
				velocity.y = move_toward(velocity.y, 0, 50)

	move_and_slide()
	position.y = clamp(position.y, 50.0, 598.0)
