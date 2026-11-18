extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(delta: float) -> void:
	# R5: Movimiento izquierda y derecha usando las acciones del Input Map
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
