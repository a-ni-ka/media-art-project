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
	zoom_state_option = ZoomStateOptions.DEFAULT


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
