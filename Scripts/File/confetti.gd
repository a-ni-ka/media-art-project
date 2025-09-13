extends CharacterBody2D

const FLY = -800
const NAMES = ["Transcipt", "Meeting Plan", "Important Information", "DO NOT DELETE"]

var direction = 0

func _ready() -> void:
	direction = randi_range(-1,1)
	$Label.text = NAMES.pick_random()
	velocity.y = FLY
	$effect.pitch_scale = randf_range(0.5, 2.0)
	$effect.play()

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	velocity.x = direction * randi_range(0, 300)
	if position.y > 1000:
		self.queue_free()
	move_and_slide()
