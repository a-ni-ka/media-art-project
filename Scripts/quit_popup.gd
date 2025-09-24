extends Popup


func _on_text_submitted(new_text: String) -> void:
	if new_text == "please":
		get_tree().quit()
