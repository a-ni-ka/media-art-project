@tool
extends Control

@export var icon: CompressedTexture2D
@export var icon_size: float
var mouse_state = false


func _ready() -> void:
	%Icon.custom_minimum_size = Vector2(icon_size, icon_size)
	%Icon.texture = icon
	$HoverBackground.hide()


func _on_mouse_entered() -> void:
	$HoverBackground.show()
	mouse_state = true


func _on_mouse_exited() -> void:
	$HoverBackground.hide()
	mouse_state = false
