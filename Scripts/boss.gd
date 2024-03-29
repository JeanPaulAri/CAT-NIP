extends CharacterBody2D

@onready var pj = get_parent().find_child("Player")
@onready var sprite = $Sprite2D

var direction : Vector2

func _ready():
	set_physics_process(false)

func  _process(_delta):
	direction = pj.position - position
	if direction.x<0:
		sprite.flip_h =true
	else:
		sprite.flip_h =false
		
func _physics_process(delta):
	velocity = direction.normalized()*100
	move_and_collide(velocity * delta)
