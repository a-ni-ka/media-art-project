@tool
extends Control

@export var icon: CompressedTexture2D
@export var icon_size: float


func _ready() -> void:
	%Icon.custom_minimum_size = Vector2(icon_size, icon_size)
	%Icon.texture = icon
	$HoverBackground.hide()


func _on_button_area_exited(body: Node2D) -> void:
	$HoverBackground.hide()


func _on_button_area_entered(body: Node2D) -> void:
	$HoverBackground.show()
