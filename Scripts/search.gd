extends TextureRect


func _input(event: InputEvent) -> void:
	if $SearchArea.mouse_hovering and event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			EventBus.zoom_clicked.emit()
