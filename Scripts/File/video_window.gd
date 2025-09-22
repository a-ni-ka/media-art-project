extends Control

@onready var player = $Window/con/VideoStreamPlayer
@onready var window = $Window
var i = preload("res://Scenes/video_window.tscn")
# Differs between normal (closes when closed) and annoying (duplicates when closed)
var mode: String = ""

func display(video, point: Vector2, window_name):
	player.stream = load(video)
	window.position = point
	window.title = window_name
	player.play()


func _on_window_close_requested() -> void:
	if mode == "annoying":
		var obj = i.instantiate()
		add_sibling(obj)
		obj.display(player.stream.file, Vector2(randi_range(10,750), randi_range(10,450)), "Reward")
		obj.mode = "annoying"
		window.position = Vector2(randi_range(10,750), randi_range(10,450))
	if mode == "normal":
		queue_free()


func _on_video_stream_player_finished() -> void:
	$Timer.start()
	$Window/Label.show()


func _on_timer_timeout() -> void:
	queue_free()
