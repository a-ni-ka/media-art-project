extends Area2D

var mouse_hovering: bool = false


func _on_body_entered(body: Node2D) -> void:
	mouse_hovering = true


func _on_body_exited(body: Node2D) -> void:
	mouse_hovering = false
