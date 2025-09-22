extends Control

var image = ""
var title = "Image"

func _ready():
	$Window/TextureRect.texture = load(image)
	$Window.title = title

func _on_window_close_requested() -> void:
	queue_free()

func _process(delta: float) -> void:
	$bounce.global_position = Vector2($Window.position.x + $Window.size.x / 2.0, $Window.position.y + $Window.size.y / 2.0)
