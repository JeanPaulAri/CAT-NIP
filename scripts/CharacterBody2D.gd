extends CharacterBody2D

const max_speed=400
const accel=1500
const friccion=600

var input=Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	

func get_input():
	input.x=int(Input.is_action_pressed("derecha")) - int(Input.is_action_pressed("izquierda"))
	input.y=int(Input.is_action_pressed("abajo")) - int(Input.is_action_pressed("arriba"))
	return input.normalized()

func player_movement(delta):
	input=get_input()
	
	if input==Vector2.ZERO:
		if velocity.length() > (friccion*delta):
			velocity-=velocity.normalized()*(friccion*delta)
		else:
			velocity=Vector2.ZERO
	else:
		velocity+=(input*accel*delta)
		velocity=velocity.limit_length(max_speed)
		
	move_and_slide()
