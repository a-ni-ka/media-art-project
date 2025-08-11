extends Label

func _process(_delta: float) -> void:
	var system_datetime := Time.get_datetime_dict_from_system()
	text = "%02d:%02d\n%02d.%02d.%04d" % [system_datetime.hour, system_datetime.minute, system_datetime.day, system_datetime.month, system_datetime.year]
