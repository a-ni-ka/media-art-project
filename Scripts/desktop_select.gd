extends Control

var is_selecting: bool = false
var selection_start: Vector2
var selection_end: Vector2


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selection_start = event.position
			selection_end = selection_start
			is_selecting = true
		else:
			is_selecting = false
		queue_redraw()
	if is_selecting and event is InputEventMouseMotion:
		selection_end = event.position
		queue_redraw()


func _draw() -> void:
	if is_selecting:
		var fill_color := Color(Color.CORNFLOWER_BLUE, .3)
		var border_color := Color.CORNFLOWER_BLUE
		var selection_rect := Rect2()
		selection_rect.position = selection_start
		selection_rect.end = selection_end
		draw_rect(selection_rect, fill_color)
		draw_rect(selection_rect, border_color, false)
