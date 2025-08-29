@tool
class_name Icon
extends Area2D

@export var icon: CompressedTexture2D :
	set(value):
		icon = value
		$Sprite2D.texture = icon
@export var title: String :
	set(value):
		title = value
		$Label.text = title

# When copying this icon, remember to connect to the mouse signal

@onready var mouse_state = false
@onready var label: Label = $Label

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Mouse":
		mouse_state = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Mouse":
		mouse_state = false

func _on_mouse_mouse_pressed() -> void:
	if mouse_state:
		# write in your code for what the icon should do
		if Gamemaster.click_icon.has(str(label.text)):
			Gamemaster.click_icon[str(label.text)] += 1
			print(Gamemaster.click_icon)
		else:
			Gamemaster.click_icon[str(label.text)] = 1
			print(Gamemaster.click_icon)
