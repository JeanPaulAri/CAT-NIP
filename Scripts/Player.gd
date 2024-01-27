extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const LIMIT_Y = 300 # Modificar el limite de Y
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# 0 Left, 1 Right, 2 Up, 3 Down 
var currentDirection = "IdleDown"

@onready var WalkSprite = $WalkSprites
@onready var IdleSprite = $IdleSprites
@onready var animationPlayer = $AnimationPlayer

func _ready():
		animationPlayer.play(currentDirection) 
		print("Player Cargado con Exito")
		
		 
func _physics_process(delta):
	movePlayer()



func movePlayer():
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")	
	if direction_x:	
		IdleSprite.visible = false
		WalkSprite.visible =true
		if(direction_x == 1):
			animationPlayer.play("Right") 
			currentDirection="IdleRight"
		else:
			animationPlayer.play("Left") 
			currentDirection="IdleLeft"
		velocity.x = direction_x * SPEED 
	else:	
		velocity.x = move_toward(velocity.x, 0, SPEED)
	print(position.y)
	if direction_y:
		WalkSprite.visible =true
		IdleSprite.visible = false
		velocity.y =  direction_y * SPEED 
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if (not Input.is_anything_pressed()):
		IdleSprite.visible = true
		WalkSprite.visible = false
		animationPlayer.play(currentDirection)
	move_and_slide()	
	if(position.y <= LIMIT_Y):
		position.y = LIMIT_Y


