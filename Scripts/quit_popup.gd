extends Popup

@onready var record_button := $MarginContainer/VBoxContainer/RecordButton
@onready var label := $MarginContainer/VBoxContainer/Label

var text_options: Array = [
	"I couldn't quite hear you... try again louder.",
	"Huh? What was that?",
	"Sorry, that was a little too quiet.",
	"Speak up please, my ears are not so good...",
	"Did you say something? Try again."
]


func _on_record_button_up() -> void:
	await record_button._on_button_up()
	#print("popup: ", record_button.volume)
	if record_button.volume < .12:
		label.text = text_options[randi_range(0, 4)]
	else:
		get_tree().quit()
