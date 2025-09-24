@tool
class_name Icon
extends Area2D

const ICON_SIZE := Vector2(70., 70.)

@export var icon: CompressedTexture2D :
	set(value):
		icon = value
		$Sprite2D.texture = icon
@export var title: String :
	set(value):
		title = value
		$Label.text = title

# When copying this icon, remember to connect to the mouse signal

@onready var label: Label = $Label

func _ready() -> void:
	$ColorRect.visible = false


func _on_button_pressed() -> void:
	if Gamemaster.click_icon.has(str(label.text)):
		Gamemaster.click_icon[str(label.text)] += 1
		print(Gamemaster.click_icon)
	else:
		Gamemaster.click_icon[str(label.text)] = 1
		print(Gamemaster.click_icon)

func _on_button_mouse_entered() -> void:
	$ColorRect.visible = true
	label.text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING

func _on_button_mouse_exited() -> void:
	$ColorRect.visible = false
	label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
