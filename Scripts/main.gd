extends Control

enum ZoomStateOptions {
	SMALLER,
	SMALL,
	DEFAULT,
	LARGE,
	LARGER,
}

@onready var canvas_layer: CanvasLayer = $SubViewportContainer/SubViewport/CanvasLayer
@onready var viewport: SubViewportContainer = $SubViewportContainer
@onready var colorblind_shader: ShaderMaterial = $SubViewportContainer.material

var zoom_state_option : ZoomStateOptions : set = _set_zoom_state
var tolerance: float = 0.0
var screen_split: bool = false


func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	$LoadingScreen.visible = true
	EventBus.zoom_clicked.connect(_on_zoom_clicked)
	EventBus.start_clicked.connect(_on_start_clicked)
	zoom_state_option = ZoomStateOptions.DEFAULT


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		$LoadingScreen.visible = true


func _on_zoom_clicked() -> void:
	var other_zoom_states: Array = ZoomStateOptions.values()
	other_zoom_states.erase(zoom_state_option)
	_set_zoom_state(other_zoom_states.pick_random())


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
		if Gamemaster.click > 0 and Gamemaster.click%12 == 0:
			if tolerance < 1:
				tolerance += .1
		else:
			if Gamemaster.click%7 == 0:
				if tolerance > 0:
					tolerance -= .1
		colorblind_shader.set_shader_parameter("tolerance", tolerance)


func _on_start_clicked() -> void:
	if screen_split:
		screen_split = false
		for child in get_children():
			if child is SubViewportContainer and child != viewport:
				child.queue_free()
		viewport.scale = Vector2(1. ,1.)
	else:
		viewport.scale = Vector2(.5, .5)
		var temp_viewport_1: SubViewportContainer = viewport.duplicate()
		var temp_viewport_2: SubViewportContainer = viewport.duplicate()
		var temp_viewport_3: SubViewportContainer = viewport.duplicate()
		screen_split = true
		add_child(temp_viewport_1)
		add_child(temp_viewport_2)
		add_child(temp_viewport_3)
		temp_viewport_1.offset_top = viewport.size.y
		temp_viewport_2.offset_left = viewport.size.x
		temp_viewport_3.offset_top = viewport.size.y
		temp_viewport_3.offset_left = viewport.size.x
