extends TextureRect

@onready var context_menu := $ContextMenu as PanelContainer


func _ready() -> void:
	context_menu.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("Right Click"):
		var mouse_event := event as InputEventMouseButton

		context_menu.position = mouse_event.position
		context_menu.visible = true

	if event.is_action("Left Click"):
		context_menu.visible = false
