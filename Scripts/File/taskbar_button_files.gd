@tool
extends "res://Scripts/taskbar_button.gd"




func _on_mouse_mouse_pressed() -> void:
	if mouse_state:
		%file_window.position = Vector2i(512,256)
		%file_window.show()
