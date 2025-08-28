@tool
extends PanelContainer
class_name ContextMenu

enum ContextMenuTypes {
	ITEM,
	BACKGROUND,
	TASKBAR,
}

const CONTEXT_MENU_MARGIN_X = 2
const CONTEXT_MENU_MARGIN_Y = 1

@export var context_menu_type: ContextMenuTypes :
	set(value):
		context_menu_type = value
		_set_menu_content()


func _ready() -> void:
	add_to_group("ContextMenu")
	_set_menu_content()


func _set_menu_content() -> void:
	for child in $MarginContainer.get_children():
		child.queue_free()
	if context_menu_type == ContextMenuTypes.BACKGROUND:
		var background := preload("res://Scenes/ContextMenu/background.tscn").instantiate()
		$MarginContainer.add_child(background)
	elif context_menu_type == ContextMenuTypes.ITEM:
		var item := preload("res://Scenes/ContextMenu/item.tscn").instantiate()
		$MarginContainer.add_child(item)
	elif context_menu_type == ContextMenuTypes.TASKBAR:
		var taskbar := preload("res://Scenes/ContextMenu/taskbar.tscn").instantiate()
		$MarginContainer.add_child(taskbar)


func place_context_menu(event: InputEventMouseButton) -> void:
	var screen_size := get_viewport_rect().size
	position = event.position
	if context_menu_type == ContextMenuTypes.TASKBAR:
		if position.x + size.x > screen_size.x:
			position.x = screen_size.x - size.x - CONTEXT_MENU_MARGIN_X
		position.y = -CONTEXT_MENU_MARGIN_Y - size.y
	elif context_menu_type == ContextMenuTypes.BACKGROUND:
		if position.x + size.x > screen_size.x:
			position.x = event.position.x - size.x
		if position.y + size.y > screen_size.y:
			position.y = event.position.y - size.y
	for item in get_tree().get_nodes_in_group("ContextMenu"):
		var control_node := item as Control
		control_node.visible = false
	visible = true


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			visible = false
