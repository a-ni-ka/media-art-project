extends CharacterBody2D

signal mouse_pressed



const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var mouse = $"."
@onready var state = "normal"

func _input(event: InputEvent) -> void:
	Input.use_accumulated_input = false
	if state == "normal":
		if event is InputEventMouseMotion:
				mouse.position = event.position
		if event.is_action_pressed("Left Click"):
			mouse_pressed.emit()
	if event.is_action_pressed("turn_mouse_into_mario"):
		state = "mario"


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _physics_process(delta: float) -> void:
	if state == "mario":
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Changes direction based on input: -1, 0, 1
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
