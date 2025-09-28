@tool
extends PanelContainer

@export var label : String :
	set(value):
		if $MarginContainer/HBoxContainer/Label:
			$MarginContainer/HBoxContainer/Label.text = value
		label = value

@export var icon : Texture2D :
	set(value):
		if $MarginContainer/HBoxContainer/TextureRect:
			$MarginContainer/HBoxContainer/TextureRect.texture = value
		icon = value

@export var pitch: float = 1.

@onready var sound := $Sound

var stylebox_normal := StyleBoxEmpty.new()
var stylebox_focused := StyleBoxFlat.new()

func _ready() -> void:
	sound.stream = load("res://assets/sounds/piano.mp3")
	sound.pitch_scale = pitch
	label = label
	icon = icon

	stylebox_focused.corner_radius_bottom_left = 5
	stylebox_focused.corner_radius_bottom_right = 5
	stylebox_focused.corner_radius_top_left = 5
	stylebox_focused.corner_radius_top_right = 5
	stylebox_focused.bg_color = Color("#b8d0e1")
	add_theme_stylebox_override("panel", stylebox_normal)


	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	add_theme_stylebox_override("panel", stylebox_focused)
	sound.play()


func _on_mouse_exited() -> void:
	add_theme_stylebox_override("panel", stylebox_normal)
