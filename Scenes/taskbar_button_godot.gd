@tool
extends "res://Scripts/taskbar_button.gd"

var click: Array = ["c", "l", "i", "c", "k"]
var letters_filtered: Array = []


func _input(event: InputEvent) -> void:
	if mouse_state and event is InputEventKey and event.is_released():
		if letters_filtered.size() > 5:
			letters_filtered.pop_front()
		for element in click:
			if element not in Gamemaster.letters:
				pass
			else:
				letters_filtered.append(element)
		if letters_filtered == click:
			EventBus.godot_clicked.emit()
	elif not mouse_state and not letters_filtered.is_empty():
		letters_filtered.clear()
