extends Control

enum ZoomStateOptions {
	SMALLER,
	SMALL,
	DEFAULT,
	LARGE,
	LARGER,
}

@onready var canvas_layer: CanvasLayer = $SubViewportContainer/SubViewport/CanvasLayer

var zoom_state_option : ZoomStateOptions : set = _set_zoom_state


func _ready() -> void:
	EventBus.zoom_clicked.connect(_on_zoom_clicked)
	zoom_state_option = ZoomStateOptions.DEFAULT


func _on_zoom_clicked() -> void:
	_set_zoom_state(ZoomStateOptions.values().pick_random())


func _set_zoom_state(value: ZoomStateOptions) -> void:
	zoom_state_option = value
	if zoom_state_option == ZoomStateOptions.DEFAULT:
		canvas_layer.offset = Vector2(0., 0.)
		canvas_layer.scale = Vector2(1., 1.)
	if zoom_state_option == ZoomStateOptions.SMALL:
		canvas_layer.scale = Vector2(.5, .5)
		canvas_layer.offset = (Vector2(1., 1.) - canvas_layer.scale) * 0.5 * size
	if zoom_state_option == ZoomStateOptions.SMALLER:
		canvas_layer.scale = Vector2(.2, .2)
		canvas_layer.offset = (Vector2(1., 1.) - canvas_layer.scale) * 0.5 * size
	if zoom_state_option == ZoomStateOptions.LARGE:
		canvas_layer.scale = Vector2(1.5, 1.5)
		canvas_layer.offset = (Vector2(1., 1.) - canvas_layer.scale) * 0.5 * size
	if zoom_state_option == ZoomStateOptions.LARGER:
		canvas_layer.scale = Vector2(2, 2)
		canvas_layer.offset = (Vector2(1., 1.) - canvas_layer.scale) * 0.5 * size

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var cursor_position: Vector2 = event.position * canvas_layer.scale + canvas_layer.offset
		if zoom_state_option == ZoomStateOptions.LARGE or zoom_state_option == ZoomStateOptions.LARGER:
			if cursor_position.y > size.y:
				canvas_layer.offset.y -= 10
			if cursor_position.x > size.x:
				canvas_layer.offset.x -= 10
			if cursor_position.y < 0:
				canvas_layer.offset.y += 10
			if cursor_position.x < 0:
				canvas_layer.offset.x += 10
