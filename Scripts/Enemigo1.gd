extends CharacterBody2D

var speed:int = 100
var player_chase:bool = false
var player=null
var enemy_attack:bool = false
var enemy_Direction="Null"
var damage=50
var HealthPoints=100
var isAlive:bool=true

@onready var moveSprites = $Movement
@onready var animationPlayer = $AnimationPlayer
@onready var attackSprites = $Attack

var spriteSize=100
func _physics_process(delta):
	if player_chase and not enemy_attack:
		moveSprites.visible=true
		attackSprites.visible=false
		position += ((player.position+Vector2(5,5))-position)/speed
		if (player.position.x+5)-position.x>spriteSize:
			animationPlayer.play("WalkRight")
		elif (player.position.x-5)-position.x>0 and (player.position.x+5)-position.x<spriteSize and abs(position.y-player.position.y)<150:
			enemy_attack=true
			enemy_Direction="Right"
			
		elif (player.position.x+5)-position.x<0 and (player.position.x+5)-position.x>-spriteSize and abs(position.y-player.position.y)<150:
			enemy_attack=true
			enemy_Direction="Left"
		else:
			animationPlayer.play("WalkLeft")
	elif enemy_attack:
		moveSprites.visible=false
		attackSprites.visible=true
		animationPlayer.play("Attack" + enemy_Direction)
		if enemy_Direction=="Left":
			$AttackLeft/CollisionAttackLeft.disabled=false
		elif enemy_Direction=="Right":
			$AttackRight/CollisionAttackRight.disabled=false
		await animationPlayer.animation_finished
		enemy_attack=false
		$AttackRight/CollisionAttackRight.disabled=true
		$AttackLeft/CollisionAttackLeft.disabled=true
		
	else:
		animationPlayer.play("IdleLelft")

func take_damage(damage):
	HealthPoints-=damage
	print("HP enemigo: "+str(HealthPoints))
	if HealthPoints<=0:
		animationPlayer.play("die"+enemy_Direction)
		await animationPlayer.animation_finished
	

func _on_attack_left_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(damage)
	else:
		pass

func _on_deteccion_body_entered(body):
	player=body # Replace with function body.
	player_chase=true

func _on_attack_right_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(damage)
	else:
		pass
