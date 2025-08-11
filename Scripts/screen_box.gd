extends MeshInstance3D

func _ready() -> void:
	var box := mesh as BoxMesh
	box.size.x = get_viewport().size.x
	box.size.y = get_viewport().size.y
