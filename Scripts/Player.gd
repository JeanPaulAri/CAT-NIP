extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# 0 Left, 1 Right, 2 Up, 3 Down /////// Idle -> 0I
var direction = "DI"

@onready var WalkSprite = $WalkSprites
@onready var IdleSprite = $IdleSprites
@onready var animationPlayer = $AnimationPlayer

func _ready():
		animationPlayer.play("IdleDown") 
		print("Player Cargado con Exito")
		
		 
func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	print("->" + str(direction))
	if direction:	
		animationPlayer.play("Right") 
		velocity.x = direction * SPEED 
	else:	
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()


func idleToWaleSprite():
	print("xd")
	WalkSprite.visible = IdleSprite.visible
	IdleSprite.visible = not IdleSprite.visible
