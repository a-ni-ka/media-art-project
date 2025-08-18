extends Area2D

signal minimize

@onready var mouse_state = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Mouse":
		mouse_state = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Mouse":
		mouse_state = false

func _on_mouse_mouse_pressed() -> void:
	# Write your code here
	if mouse_state:
		minimize.emit()
