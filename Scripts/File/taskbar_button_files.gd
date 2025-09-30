@tool
extends "res://Scripts/taskbar_button.gd"

var click: Array = ["C", "L", "I", "C", "K"]
var letters_filtered: Array = []


func _input(event: InputEvent) -> void:
	if mouse_state:
		if event is InputEventKey and event.is_pressed():
			var event_key := event as InputEventKey
			if letters_filtered.size() > 5:
				letters_filtered.pop_front()
			letters_filtered.append(event_key.as_text_keycode())
		if letters_filtered == click:
			letters_filtered.clear()
			EventBus.explorer_clicked.emit()
	else:
		letters_filtered.clear()
