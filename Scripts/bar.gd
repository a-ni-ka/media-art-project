extends Area2D

@onready var mouse_state = false

signal move

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Mouse":
		mouse_state = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Mouse":
		mouse_state = false

func _on_mouse_mouse_pressed() -> void:
	if mouse_state:
		move.emit()
