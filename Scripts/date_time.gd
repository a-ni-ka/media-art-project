extends Label

@onready var sound: AudioStreamPlayer2D = $Sound

func _process(_delta: float) -> void:
	var system_datetime := Time.get_datetime_dict_from_system()
	text = "%02d:%02d\n%02d.%02d.%04d" % [system_datetime.hour, system_datetime.minute, system_datetime.day, system_datetime.month, system_datetime.year]
	if system_datetime.minute == 28 or system_datetime.minute == 53:
		sound.stream = load("res://assets/sounds/cuckoo-clock.mp3")
		sound.play()
