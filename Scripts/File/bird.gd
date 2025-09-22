extends CharacterBody2D


var speed = randi_range(6000,8000)
var falling = false

@onready var sprite: AnimatedSprite2D = $sprite
var direction = 0

func _ready():
	direction = [-1,1].pick_random()
	if direction > 0:
		sprite.flip_h = true
	
	
func _physics_process(delta: float) -> void:
	if falling:
		velocity.y = speed * 3 *delta
		if position.y > 1000:
			queue_free()
		move_and_slide()
	else:
		velocity.x = direction * speed * delta
		if direction == -1 and global_position.x < -50:
			queue_free()
		elif direction == 1 and global_position.x > 1650:
			queue_free()
		if move_and_slide():
			falling = true
			velocity.x = 0
			sprite.animation = "crash"
			sprite.rotate(90.0)
			$sound.stream = load("res://assets/sounds/duck-falling.mp3")
			$sound.volume_db = -10.0
			$sound.play()
		
