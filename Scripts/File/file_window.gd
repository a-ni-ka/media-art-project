extends Window

var state = "none"
var confetti = preload("res://Scenes/File_Window/confetti.tscn")
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

func _on_confetti_display(name: String):
	print(name)
