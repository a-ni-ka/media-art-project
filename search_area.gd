extends Area2D

# signal clicked

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Left Click"):
		print("click?")
		# clicked.emit()
