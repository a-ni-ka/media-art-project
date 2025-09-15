extends Window


var state = "none"
var confetti = preload("res://Scenes/File_Window/confetti.tscn")
var reader = preload("res://Scenes/File_Window/reader.tscn")
var secret_window = preload("res://Scenes/File_Window/secret_window.tscn")
var tries = 0
var passwords = ["password", "mince", "secret", "guess", "castle", "drowssap", "please", "algebra", "sondern", "fähigkeit"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	position = Vector2(-1000, 0)

func _on_close_requested() -> void:
	self.position = Vector2i(-1000, 0)
	self.size = Vector2i(267,450)
	self.hide()
	
func _on_hobbies_pressed() -> void:
	if state != "hobby":
		$work_files.position = Vector2(269,-300)
		$hobby_files.position = Vector2 (269,3)
		state = "hobby"
	else:
		pass

func _on_work_pressed() -> void:
	if state != "work":
		$work_files.position = Vector2(269,3)
		$hobby_files.position = Vector2(269,-300)
		state = "work"
	else:
		pass

func _on_file_button_pressed() -> void:
	var obj = confetti.instantiate()
	obj.position = position + Vector2i(size.x / 2.0, 50)
	obj.display.connect(_on_confetti_display)
	add_sibling(obj)

func _on_confetti_display(type: String, point: Vector2):
	var obj = reader.instantiate()
	obj.write(type, point)
	add_sibling(obj)

func _on_secret_pressed() -> void:
	var obj = secret_window.instantiate()
	obj.closed.connect(_on_secret_closed)
	obj.password = passwords[tries % 10]
	obj.tries = tries
	add_child(obj)

func _on_secret_closed(x):
	tries += x
	
