extends Control

signal result(x:bool)

var order = []
var input = []
var last_button: TextureButton
var itt = 0
var timer_state = ""
var games = 1
var max_games = 10

#region Var Child Assigment

@onready var up = $Window/VBoxContainer/up
@onready var left = $Window/VBoxContainer/HBoxContainer/left
@onready var right = $Window/VBoxContainer/HBoxContainer/right
@onready var down = $Window/VBoxContainer/down
@onready var timer: Timer = $Timer
@onready var buttons = get_tree().get_nodes_in_group("buttons")
@onready var sound = $AudioStreamPlayer2D
@onready var label: Label = $Window/Label
#endregion

#region Image loading

var up_pressed = preload("res://assets/visuals/simon_says/up_pressed.png")
var up_unpressed = preload("res://assets/visuals/simon_says/up_unpressed.png")
var left_pressed = preload("res://assets/visuals/simon_says/left_pressed.png")
var left_unpressed = preload("res://assets/visuals/simon_says/left_unpressed.png")
var right_pressed = preload("res://assets/visuals/simon_says/right_pressed.png")
var right_unpressed = preload("res://assets/visuals/simon_says/right_unpressed.png")
var down_pressed = preload("res://assets/visuals/simon_says/down_pressed.png")
var down_unpressed = preload("res://assets/visuals/simon_says/down_unpressed.png")
#endregion

func game():
	if itt == 0:
		for i in games:
			order.append(randi_range(1,4))
		for butt in buttons:
			butt.disabled = true
		sound.stream = load("res://assets/sounds/pop.mp3")
		timer.wait_time = 0.5
	sound.play()
	timer_state = "changing"
	match order[itt]:
		1:
			up.texture_normal = up_pressed
			last_button = up
			timer.start()
		2:
			left.texture_normal = left_pressed
			last_button = left
			timer.start()
		3:
			right.texture_normal = right_pressed
			last_button = right
			timer.start()
		4:
			down.texture_normal = down_pressed
			last_button = down
			timer.start()

func _on_ready() -> void:
	label.hide()
	game()

func _on_timer_timeout() -> void:
	if timer_state == "changing":
		match last_button.name:
			"up":
				last_button.texture_normal = up_unpressed
			"left":
				last_button.texture_normal = left_unpressed
			"right":
				last_button.texture_normal = right_unpressed
			"down":
				last_button.texture_normal = down_unpressed
		timer_state = "continue"
		timer.start()
	elif timer_state == "continue":
		itt += 1
		if itt < order.size():
			timer.stop()
			game()
		else:
			for butt in buttons:
				butt.disabled = false
			timer.stop()
			itt = 0
			sound.stream = load("res://assets/sounds/tick.wav")
	elif timer_state == "new":
		timer.stop()
		label.hide()
		game()
	elif timer_state == "end":
		queue_free()

func _on_button_pressed(name) -> void:
	sound.play()
	match name:
		"up":
			input.append(1)
		"down":
			input.append(4)
		"left":
			input.append(2)
		"right":
			input.append(3)
	if order.size() == input.size():
		if input == order:
			sound.stream = load("res://assets/sounds/wheeeeee.wav")
			sound.play()
			input.clear()
			order.clear()
			timer_state = "new"
			label.text = "Game: " + str(games) +"/"+ str(max_games)
			label.show()
			games += 1
			if max_games == games:
				timer_state = "end"
				result.emit(true)
				label.text = "You Won!"
				timer.start(2.0)
			else:
				timer.start(5.0)
		else:
			result.emit(false)
			label.text = "You Lost"
			label.show()
			timer_state = "end"
			timer.start(2.0)
