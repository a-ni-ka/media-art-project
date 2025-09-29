@tool
extends Icon

@onready var sound: AudioStreamPlayer2D = $Sound

var tween: Tween


func _ready() -> void:
	position = Vector2(57., 57.)
	rotation = 0.0


func _on_button_pressed() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	var new_position: Vector2 = Vector2(randf_range(57, 1543), randf_range(57, 743))
	sound.stream = load("res://assets/sounds/rotate_whoosh.mp3")
	sound.pitch_scale = 2.
	sound.play(1.)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_parallel()
	tween.tween_property($".", "position", new_position, 1)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_method(rotate, 0.5, 1., 1)


func activate_icon() -> void:
	pass
