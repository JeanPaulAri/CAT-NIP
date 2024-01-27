extends CharacterBody2D

var speed:int = 300
var player_chase:bool = false
var player=null

@onready var moveSprites = $Movement
@onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	if player_chase:
		position += ((player.position+Vector2(5,5))-position)/speed
		if (player.position.x+5)-position.x>0:
			animationPlayer.play("WalkRight")
		else:
			animationPlayer.play("WalkLeft")
	else:
		animationPlayer.play("IdleLelft")


func _on_area_2d_body_entered(body):
	player=body # Replace with function body.
	player_chase=true
