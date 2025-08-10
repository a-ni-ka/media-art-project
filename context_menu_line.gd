@tool
extends MarginContainer

@export var label : String :
	set(value):
		if $HBoxContainer/Label:
			$HBoxContainer/Label.text = value
		label = value

@export var icon : Texture2D :
	set(value):
		if $HBoxContainer/TextureRect:
			$HBoxContainer/TextureRect.texture = value
		icon = value

func _ready() -> void:
	label = label
	icon = icon
