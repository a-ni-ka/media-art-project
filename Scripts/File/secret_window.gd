extends Control

signal closed(x)

var tries = 0
var password = ""
@onready var entry = $Window/PanelContainer/VBoxContainer/LineEdit


func _on_con_pressed() -> void:
	tries += 1
	if password == entry.text:
		pass
	elif tries > 50:
		pass

func _on_den_pressed() -> void:
	tries += 1
	closed.emit(tries)
	queue_free()


func _on_window_close_requested() -> void:
	closed.emit(tries)
	queue_free()
