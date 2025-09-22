extends CharacterBody2D


var speed = randi_range(300,500)

@onready var sprite: AnimatedSprite2D = $sprite
var direction = 0

func _ready():
	direction = [-1,1].pick_random()
	if direction > 0:
		sprite.flip_h = true
	
func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	move_and_slide()
