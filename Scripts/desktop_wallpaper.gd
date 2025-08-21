extends TextureRect

@onready var context_menu := $ContextMenu as ContextMenu


func _ready() -> void:
	context_menu.hide()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_RIGHT and mouse_event.pressed:
			context_menu.place_context_menu(event)
		#var mouse_event := event as InputEventMouseButton
#
		#context_menu.position = mouse_event.position
		#context_menu.visible = true
