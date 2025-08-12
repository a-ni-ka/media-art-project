class_name Icon
extends Area2D

@onready var label: Label = $Label

func _on_body_entered(body: Node2D) -> void:
	print("entered")
	if body.name == "Mouse":
		print("mouse")
		if Input.is_action_pressed("Left Click"):
			Gamemaster.click_icon[label.text] += 1
			execution()

func execution():
	print(Gamemaster.click_icon)
