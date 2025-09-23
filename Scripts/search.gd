extends TextureRect

var mouse_hovering: bool = false


func _on_mouse_entered() -> void:
	mouse_hovering = true


func _on_mouse_exited() -> void:
	mouse_hovering = false


func _input(event: InputEvent) -> void:
	if mouse_hovering and event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			EventBus.zoom_clicked.emit()
