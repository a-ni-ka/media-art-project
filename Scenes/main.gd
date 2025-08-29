extends Control

enum ZoomStateOptions {
	SMALLER,
	SMALL,
	DEFAULT,
	LARGE,
	LARGER,
}

var zoom_state_options : ZoomStateOptions

func _set_zoom_state() -> void:
	if zoom_state_options == ZoomStateOptions.DEFAULT:
		pass
	pass
