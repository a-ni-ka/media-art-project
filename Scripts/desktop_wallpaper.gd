extends TextureRect

@onready var context_menu := $ContextMenu as ContextMenu
@onready var quit_popup: Popup = $QuitPopup


func _ready() -> void:
	context_menu.hide()


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_RIGHT and mouse_event.pressed:
			context_menu.place_context_menu(event)


# Code additions made by Thies
var bird = preload("res://Scenes/File_Window/bird.tscn")
func _on_file_window_change_wallpaper(path: Variant) -> void:
	texture = load(path)

func _on_file_window_bird_up() -> void:
	if Gamemaster.click_icon["Reports"] > 10:
		$sound.stream = load("res://assets/sounds/birb-up.mp3")
		$sound.play()
		for i in 500:
			var obj = bird.instantiate()
			add_child(obj)
			if obj.direction < 0:
				obj.global_position = Vector2(randi_range(1700, 2700), randi_range(20,800))
			else:
				obj.global_position = Vector2(randi_range(-100, -1100), randi_range(20,800))


func _on_search_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "quit":
		quit_popup.show()
