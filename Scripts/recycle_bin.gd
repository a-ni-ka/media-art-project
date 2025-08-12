extends Area2D

func _ready() -> void:
	position = Vector2(60., 40.)

func _on_mouse_entered() -> void:
	position = Vector2(
		randf_range(50, get_viewport_rect().size.x - 50),
		randf_range(50, get_viewport_rect().size.y - 50)
	)
