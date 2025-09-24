extends Control

@onready var timer = $Timer


func _on_visibility_changed() -> void:
	var wait_time: float = randf_range(2.5, 7.7)
	if visible:
		timer.start(wait_time)


func _on_timer_timeout() -> void:
	visible = false
