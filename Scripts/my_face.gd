@tool
extends Icon

var icon_active: bool = false

func activate_icon() -> void:
	if icon_active:
		queue_free()
	icon_active = true
	EventBus.face_clicked.emit()
