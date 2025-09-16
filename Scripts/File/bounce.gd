extends AnimatableBody2D

@onready var window: Window = $"../file_window"
@onready var coll = $bounce_coll

func _ready() -> void:
	window.size_changed.connect(_on_file_window_size_changed)

func _physics_process(_delta: float) -> void:
	global_position = Vector2(window.position.x + window.size.x / 2.0, window.position.y + window.size.y / 2.0)

func _on_file_window_size_changed() -> void:
	coll.shape.size = Vector2(window.size.x + 15, window.size.y + 37)
