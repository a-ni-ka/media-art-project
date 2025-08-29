@tool
extends Control

@export var icon: CompressedTexture2D
@export var icon_size: float


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	%Icon.custom_minimum_size = Vector2(icon_size, icon_size)
	%Icon.texture = icon
	$HoverBackground.hide()


func _on_mouse_entered() -> void:
	$HoverBackground.show()


func _on_mouse_exited() -> void:
	$HoverBackground.hide()
