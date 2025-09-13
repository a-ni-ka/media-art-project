extends AnimatableBody2D

@onready var window: Window = %file_window

func _physics_process(delta: float) -> void:
	global_position = Vector2(window.position.x + window.size.x / 2.0, window.position.y + window.size.y / 2.0)
