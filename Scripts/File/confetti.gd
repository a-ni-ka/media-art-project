extends RigidBody2D

signal display(type: String, point: Vector2)

const FLY = -1000
const NAMES = ["Transcipt", "Meeting Plan", "Important Information", "DO NOT DELETE", "Union Letter", "Contract"]

var direction = 0
var motion = Vector2(0,0)

func _ready() -> void:
	direction = randi_range(-1,1)
	$Label.text = NAMES.pick_random()
	$effect.pitch_scale = randf_range(0.5, 2.0)
	$effect.play()
	if direction != 0:
		add_constant_torque(4000 * direction)
	apply_impulse(Vector2(direction * randi_range(300, 1000), FLY))

func _on_button_pressed() -> void:
	display.emit($Label.text, global_position)
