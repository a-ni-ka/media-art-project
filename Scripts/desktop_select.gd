extends Control

var is_selecting: bool = false
var selection_start: Vector2
var selection_end: Vector2
var selection_box := StyleBoxFlat.new()
var morph_ratio: float = 0. :
	set(value):
		morph_ratio = value
		queue_redraw()
var tween: Tween
var selection_offset: Vector2 :
	set(value):
		selection_offset = value
		queue_redraw()

func _ready() -> void:
	var fill_color := Color(Color.CORNFLOWER_BLUE, .3)
	var border_color := Color.CORNFLOWER_BLUE
	selection_box.bg_color = fill_color
	selection_box.border_color = border_color
	selection_box.set_border_width_all(2)
	selection_box.corner_detail = 16


func _move_selection(_value: float) -> void:
	selection_offset.y -= _value * 7
	selection_offset.x = sin(_value * PI * 5) * 100
	queue_redraw()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if tween:
				tween.kill()
			morph_ratio = 0.
			selection_offset = Vector2.ZERO
			selection_start = event.position
			selection_end = selection_start
			is_selecting = true
			accept_event()
		elif event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			if tween:
				tween.kill()
			tween = create_tween()
			is_selecting = false
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.set_parallel()
			tween.tween_property(self, "morph_ratio", 1, 1)
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_method(_move_selection, 0., 1., 10.)
			accept_event()
		queue_redraw()
	if is_selecting and event is InputEventMouseMotion:
		selection_end = event.position
		queue_redraw()
		accept_event()


func _draw() -> void:
	var selection_rect := Rect2()
	selection_rect.position = selection_start + selection_offset
	selection_rect.end = selection_end + selection_offset

	if selection_rect.position.x > selection_rect.end.x:
		var t := selection_rect.position.x
		selection_rect.position.x = selection_rect.end.x
		selection_rect.end.x = t

	if selection_rect.position.y > selection_rect.end.y:
		var t := selection_rect.position.y
		selection_rect.position.y = selection_rect.end.y
		selection_rect.end.y = t

	var center := selection_rect.get_center()
	var radius := sqrt(selection_rect.get_area() / PI)
	var corner_radius := roundi(lerpf(0., radius, morph_ratio))

	selection_box.set_corner_radius_all(corner_radius)

	var new_width := lerpf(selection_rect.size.x, 2. * radius, morph_ratio)
	var new_height := lerpf(selection_rect.size.y, 2. * radius, morph_ratio)
	var new_size = Vector2(new_width, new_height)
	var new_rect := Rect2(center - 0.5 * new_size, new_size)

	draw_style_box(selection_box, new_rect)
