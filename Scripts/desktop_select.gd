extends Control

@onready var bubble_area: Area2D = $BubbleArea
@onready var bubble_shape: CircleShape2D = $BubbleArea/BubbleShape.shape

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
var has_target := false

func _ready() -> void:
	bubble_area.area_entered.connect(_on_area_entered)
	var fill_color := Color(Color.CORNFLOWER_BLUE, .3)
	var border_color := Color.CORNFLOWER_BLUE
	selection_box.bg_color = fill_color
	selection_box.border_color = border_color
	selection_box.set_border_width_all(2)
	selection_box.corner_detail = 16


func _on_area_entered(area: Area2D) -> void:
	if is_selecting or has_target:
		return
	has_target = true
	_move_bubble_to_icon(area)
	#if "activate_icon" in area:
		#area.activate_icon()


func _move_selection(value: float) -> void:
	selection_offset.y -= value * 7
	selection_offset.x = sin(value * PI * 5) * 100
	queue_redraw()


func _set_bubble_radius(radius: float) -> void:
	var center := _get_bubble_center()
	selection_start = center - Vector2(radius, radius)
	selection_end = center + Vector2(radius, radius)
	queue_redraw()


func _get_bubble_radius() -> float:
	return ((selection_start - selection_end) * .5).length()


func _set_bubble_center(center: Vector2) -> void:
	var bubble_center := _get_bubble_center()
	selection_offset = Vector2.ZERO
	selection_start += center - bubble_center
	selection_end += center - bubble_center
	queue_redraw()


func _get_bubble_center() -> Vector2:
	return (selection_start + selection_end) / 2.0 + selection_offset


func _move_bubble_to_icon(icon: Area2D) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	var new_center: Vector2 = icon.position
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_parallel()
	tween.tween_method(_set_bubble_center, _get_bubble_center(), new_center, .2)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_method(_set_bubble_radius, _get_bubble_radius(), icon.ICON_SIZE.x * 0.6, .4)
	tween.tween_callback(_set_bubble_center.bind(Vector2(-1000, -1000))).set_delay(1.)
	if "activate_icon" in icon:
		tween.chain().tween_callback(icon.activate_icon)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if tween:
				tween.kill()
			has_target = false
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

	bubble_area.position = center
	bubble_shape.radius = radius
