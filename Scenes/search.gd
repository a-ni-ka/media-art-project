extends TextureRect

enum ZoomStateOptions {
	SMALLER,
	SMALL,
	DEFAULT,
	LARGE,
	LARGER,
}

var zoom_state_options : ZoomStateOptions
var mouse_hovering: bool = false


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	mouse_hovering = true


func _on_mouse_exited() -> void:
	mouse_hovering = false


func _set_zoom_state() -> void:
	if zoom_state_options == ZoomStateOptions.DEFAULT:
		pass
	pass


func _input(event: InputEvent) -> void:
	if mouse_hovering and event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			_set_zoom_state()
			print("left clickckckckc")
