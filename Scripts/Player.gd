extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# 0 Left, 1 Right, 2 Up, 3 Down /////// Idle -> 0I
var direction = "DI"

@onready var WalkSprite = $WalkSprites
@onready var IdleSprite = $IdleSprites
@onready var animationPlayer = $AnimationPlayer
@onready var AttackSprite = $"Attack(temporal)"

func _ready():
		animationPlayer.play("IdleDown") 
		print("Player Cargado con Exito")
		
		 
func _physics_process(delta):
<<<<<<< Updated upstream

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
=======
	movePlayer()
	attack()

func attack():
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ataque"):
		AttackSprite.visible=true
		IdleSprite.visible = false
		WalkSprite.visible = false
		$Area2D/CollisionShape2D.disabled=false
		if(direction_x == 1):
			animationPlayer.play("AttackRight")
		else:
			animationPlayer.play("AttackLeft")
	else:
		AttackSprite.visible=false
		$Area2D/CollisionShape2D.disabled=true
>>>>>>> Stashed changes

	var direction = Input.get_axis("ui_left", "ui_right")
	print("->" + str(direction))
	if direction:	
		animationPlayer.play("Right") 
		velocity.x = direction * SPEED 
	else:	
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()


<<<<<<< Updated upstream
func idleToWaleSprite():
	print("xd")
	WalkSprite.visible = IdleSprite.visible
	IdleSprite.visible = not IdleSprite.visible
=======


func _on_area_2d_body_entered(body):
	if body.is_in_group("hit"):
		body.takedamage()
	else:
		pass
>>>>>>> Stashed changes
