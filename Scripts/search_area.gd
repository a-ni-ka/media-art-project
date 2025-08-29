extends Area2D

var mouse_hovering: bool = false


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	mouse_hovering = true


func _on_mouse_exited() -> void:
	mouse_hovering = false


func _input(event: InputEvent) -> void:
	if mouse_hovering and event is InputEventMouseButton:
		print("click??")
