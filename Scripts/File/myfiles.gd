@tool
extends Icon

@onready var window: Window = $file_window


func _on_button_pressed() -> void:
	if Gamemaster.click_icon.has(str(label.text)):
		Gamemaster.click_icon[str(label.text)] += 1
		print(Gamemaster.click_icon)
	else:
		Gamemaster.click_icon[str(label.text)] = 1
		print(Gamemaster.click_icon)
	window.position = get_global_mouse_position()
	window.show()
