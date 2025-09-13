extends Control

func _process(delta: float) -> void:
	var time_left = str($Timer.time_left)
	$Label.text = "Countdown: " + time_left.erase(3,time_left.length() - 3)

func write(type: String, point):
	match type:
		"Transcipt":
			$Window/TextEdit.text = "This is transcript"
		"Meeting Plan":
			$Window/TextEdit.text = "This is meeting plan"
		"Important Information":
			pass
		"DO NOT DELETE":
			pass
		"Union Letter":
			pass
		"Contract":
			pass


func _on_window_close_requested() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
