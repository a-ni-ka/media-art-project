extends Control

signal select(number)

var title = ""
var text = ""
var correct_number = 0
var number_range = [0,100]

@onready var number_display: Label = $Window/VBoxContainer/PanelContainer/numberdisplay
@onready var text_display: LineEdit = $Window/VBoxContainer/Text
@onready var timer: Timer = $Timer
@onready var window: Window = $Window


func _ready():
	window.title = title
	text_display.text = text
	number_display.text = str(randi_range(number_range[0],number_range[1]))
	timer.wait_time = 1.0
	timer.start()

func _on_timer_timeout() -> void:
	number_display.text = str(randi_range(number_range[0],number_range[1]))
	timer.stop()
	timer.start()

func _on_con_pressed() -> void:
	timer.stop()
	select.emit(int(number_display.text))
	queue_free()

func _on_den_pressed() -> void:
	queue_free()
