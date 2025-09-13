@tool
extends Area2D

@onready var window: Window = %file_window

func _process(delta: float) -> void:
	position = Vector2(window.position.x + window.size.x / 2.0, window.position.y + window.size.y / 2.0)
	$bounce_coll.position = Vector2(window.position.x + window.size.x / 2.0, window.position.y + window.size.y / 2.0)
