extends Control

signal closed(x)

var tries = 0
var password = ""
@onready var entry = $Window/PanelContainer/VBoxContainer/LineEdit
var reward = preload("res://Scenes/video_window.tscn")
var rick = "res://assets/video/rickroll.tres"

func _on_con_pressed() -> void:
	tries += 1
	if password == entry.text and randi_range(0,10) < 6:
		var obj = reward.instantiate()
		obj.mode = "annoying"
		add_sibling(obj)
		obj.display(rick, Vector2(randi_range(10,750), randi_range(10,450)), "Reward")
	elif tries > 50:
		pass

func _on_den_pressed() -> void:
	tries += 1
	closed.emit(tries)
	queue_free()


func _on_window_close_requested() -> void:
	closed.emit(tries)
	queue_free()
