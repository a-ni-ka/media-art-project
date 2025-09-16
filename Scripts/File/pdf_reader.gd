@tool
extends Control



func write(text: String, point):
	if point > Vector2(50,50):
		$Window.position = point
	else:
		$Window.position = Vector2(point.x, 100)
	$Window/TextEdit.text = text

func _on_timer_timeout() -> void:
	$pop.play()

func _on_pop_finished() -> void:
	queue_free()

func _process(_delta: float) -> void:
	$bounce.global_position = Vector2($Window.position.x + $Window.size.x / 2.0, $Window.position.y + $Window.size.y / 2.0 - 11)

func _on_window_size_changed() -> void:
	$bounce/CollisionShape2D.shape.size = Vector2($Window.size.x + 15, $Window.size.y + 37)
