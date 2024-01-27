extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const LIMIT_Y = 300

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# 0 Left, 1 Right, 2 Up, 3 Down /////// Idle -> 0I

var currentDirection = "IdleDown"
var isAttacking=false
var isAlive=true
var playerHP=100
var damage=50

@onready var WalkSprite = $WalkSprites
@onready var IdleSprite = $IdleSprites
@onready var animationPlayer = $AnimationPlayer
@onready var AttackSprite = $"Attack(temporal)"

func _ready():
		animationPlayer.play(currentDirection) 
		print("Player Cargado con Exito")
		 
func _physics_process(delta):
	if isAlive:
		if not is_on_floor():
			velocity.y += gravity * delta

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if(isAttacking!=true):
			movePlayer()
		attack()
	else:
		die()

func take_damage(damage):
	print("Player HP: "+str(playerHP))
	playerHP-=damage
	if playerHP<=0:
		isAlive=false

func die():
	AttackSprite.visible=true
	IdleSprite.visible = false
	WalkSprite.visible = false
	if(currentDirection == "IdleRight"):
		animationPlayer.play("DieRight")
	else:
		animationPlayer.play("DieLeft")

func attack():
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ataque"):
		AttackSprite.visible=true
		IdleSprite.visible = false
		WalkSprite.visible = false
		if(currentDirection == "IdleRight"):
			animationPlayer.play("AttackRight")
			isAttacking=true
			$AreaDerecha/ColisionDerecha.disabled=false
			await animationPlayer.animation_finished
			$AreaDerecha/ColisionDerecha.disabled=true
		elif(currentDirection == "IdleLeft"):
			animationPlayer.play("AttackLeft")
			isAttacking=true
			$AreaIzquierda/ColisionIzquierda.disabled=false
			await animationPlayer.animation_finished
			$AreaIzquierda/ColisionIzquierda.disabled=true
	else:
		AttackSprite.visible=false
		isAttacking=false

func idleToWaleSprite():
	#print("xd")
	WalkSprite.visible = IdleSprite.visible
	IdleSprite.visible = not IdleSprite.visible

func movePlayer():
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_x:
		IdleSprite.visible = false
		WalkSprite.visible =true
		if(direction_x == 1 and isAttacking==false):
			animationPlayer.play("Right") 
			currentDirection="IdleRight"
		elif(direction_x==-1 and isAttacking==false):
			animationPlayer.play("Left") 
			currentDirection="IdleLeft"
		velocity.x = direction_x * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#print(position.y)
	if direction_y:
		WalkSprite.visible =true
		IdleSprite.visible = false
		velocity.y =  direction_y * SPEED 
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if (not Input.is_anything_pressed() and isAttacking==false):
		IdleSprite.visible = true
		WalkSprite.visible = false
		animationPlayer.play(currentDirection)
	move_and_slide()
	if(position.y <= LIMIT_Y):
		position.y = LIMIT_Y

func MoveCamera():
	pass

func _on_attack_left_body_entered(body):
	body.take_damage(damage)

func _on_attack_right_body_entered(body):
	body.take_damage(damage)
