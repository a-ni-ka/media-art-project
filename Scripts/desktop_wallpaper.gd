extends TextureRect

const WARP_SHADER = preload("res://assets/visuals/warp.gdshader")

@onready var context_menu := $ContextMenu as ContextMenu
@onready var quit_popup: Popup = $QuitPopup
@onready var ad_popup: Popup = $AdPopup


func _ready() -> void:
	context_menu.hide()
	EventBus.face_clicked.connect(_on_face_clicked)
	EventBus.explorer_clicked.connect(_on_explorer_clicked)
	EventBus.godot_clicked.connect(_on_godot_clicked)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_RIGHT and mouse_event.pressed:
			context_menu.place_context_menu(event)


# Code additions made by Thies
var bird = preload("res://Scenes/File_Window/bird.tscn")
func _on_file_window_change_wallpaper(path: Variant) -> void:
	material = null
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
	else:
		ad_popup.show()


func _on_face_clicked() -> void:
	if not $Face.visible:
		$Face.show()
		$Face.play("default")


func _on_explorer_clicked() -> void:
	if material == null:
		material = ShaderMaterial.new()
		material.shader = WARP_SHADER


func _on_godot_clicked() -> void:
	if get_children().size() > 20:
		for child in get_children():
			if child is Sprite2D:
				child.queue_free()
				pass
	var sprite:= Sprite2D.new()
	var sprite_scale:= randf_range(0.1, 1.0)
	add_child(sprite)
	sprite.texture = preload("res://icon.svg")
	sprite.position = Vector2(randf_range(57, 1543), randf_range(57, 743))
	sprite.scale = Vector2(sprite_scale, sprite_scale)
	sprite.rotation = randf_range(-2., 2.)
