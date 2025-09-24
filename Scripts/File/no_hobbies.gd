extends Control


func _on_window_close_requested() -> void:
	queue_free()
