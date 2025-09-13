extends RigidBody2D

const FLY = -30
const NAMES = ["Transcipt", "Meeting Plan", "Important Information", "DO NOT DELETE"]

var direction = 0
var motion = Vector2(0,0)

func _ready() -> void:
	direction = randi_range(-1,1)
	$Label.text = NAMES.pick_random()
	motion.y = FLY
	$effect.pitch_scale = randf_range(0.5, 2.0)
	$effect.play()

func _physics_process(delta: float) -> void:
	motion += get_gravity() * delta * mass
	motion.x = direction * randi_range(100, 600) * delta
	if position.y > 1000:
		self.queue_free()
	move_and_collide(motion)
