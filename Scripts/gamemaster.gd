extends Node


#How many times the left mouse button was clicked
var click = 0
# Dic including which icons were clicked on how often
var click_icon = {}
#Last 10 letters typed
var letters = []
#Event flags, can be stored in array
var flags = []
# letters written out in a string
var word = ""
func _input(event: InputEvent) -> void:
	# Counts amount of clicks
	if event.is_action_pressed("Left Click"):
		click += 1
	
	# Saves last ten letters typed in array
	if event is InputEventKey:
		match event.keycode:
			KEY_A:
				letters.append("a")
			KEY_B:
				letters.append("b")
			KEY_C:
				letters.append("c")
			KEY_D:
				letters.append("d")
			KEY_E:
				letters.append("e")
			KEY_F:
				letters.append("f")
			KEY_G:
				letters.append("g")
			KEY_H:
				letters.append("h")
			KEY_I:
				letters.append("i")
			KEY_J:
				letters.append("j")
			KEY_K:
				letters.append("k")
			KEY_L:
				letters.append("l")
			KEY_M:
				letters.append("m")
			KEY_N:
				letters.append("n")
			KEY_O:
				letters.append("o")
			KEY_P:
				letters.append("p")
			KEY_Q:
				letters.append("q")
			KEY_R:
				letters.append("r")
			KEY_S:
				letters.append("s")
			KEY_T:
				letters.append("t")
			KEY_U:
				letters.append("u")
			KEY_V:
				letters.append("v")
			KEY_W:
				letters.append("w")
			KEY_X:
				letters.append("x")
			KEY_Y:
				letters.append("y")
			KEY_Z:
				letters.append("z")
			_:
				pass
		
		if letters.size() > 10:
			print(letters.pop_front())
		
		print(letters)
