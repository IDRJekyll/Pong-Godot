extends CharacterBody2D

@export var speed = 400.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("p1_up", "p1_down")
	velocity.y = direction * speed
	move_and_slide()
	
	position.y = clamp(position.y, 50.0, 598.0)
