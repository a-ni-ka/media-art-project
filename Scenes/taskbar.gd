extends Control

@onready var context_menu := $ContextMenu as ContextMenu

const CONTEXT_MENU_MARGIN_X = 2
const CONTEXT_MENU_MARGIN_Y = 1


func _ready() -> void:
	context_menu.hide()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_RIGHT and mouse_event.pressed:
			context_menu.place_context_menu(mouse_event)
		#var mouse_event := event as InputEventMouseButton
		#var screen_size := get_viewport_rect().size
#
		#context_menu.position.x = mouse_event.position.x
		#if context_menu.position.x + context_menu.size.x > screen_size.x:
			#context_menu.position.x = screen_size.x - context_menu.size.x - CONTEXT_MENU_MARGIN_X
		#context_menu.position.y = -CONTEXT_MENU_MARGIN_Y - context_menu.size.y
		#context_menu.visible = true
