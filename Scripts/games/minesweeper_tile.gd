class_name Tile
extends Control

enum State {MINE, NORMAL}

signal game_over
signal click(side)

var tile_state: State
var neigh = []
var dif: float = 1.0
var num_bombs = 0
var pressed = false
@onready var area = $Area2D
@onready var sprite = $Area2D/sprite


func _ready() -> void:
	sprite.animation = "blank"
	scale = Vector2(25.0/dif, 25.0/dif)
	area.scale = Vector2(25.0/dif, 25.0/dif)
	area.position = Vector2(size.x * 25.0/dif / 2, size.y * 25.0/dif / 2)
	if randi_range(1,int(dif/2)) % int(dif/2) == 0:
		tile_state = State.MINE
	else:
		tile_state = State.NORMAL
	
func _on_mouse_entered() -> void:
	if not pressed:
		sprite.animation = "hover"

func _on_mouse_exited() -> void:
	if not pressed:
		sprite.animation = "blank"


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click") and not pressed:
		var excl = []
		reveal(excl, false)
		pressed = true
		click.emit("left")
	elif event.is_action_pressed("Right Click"):
		if pressed:
			sprite.animation = "blank"
			pressed = false
			click.emit("none")
		else:
			sprite.animation = "flag"
			pressed = true
			click.emit("right")

func reveal(excl: Array, end: bool):
	var mines = check()
	if tile_state == State.MINE:
		sprite.animation = "bomb_pressed"
		if not end:
			game_over.emit()
		else:
			pressed = true
	elif mines == 0:
		sprite.animation = "empty"
		if not end:
			for i in neigh:
				if i.tile_state == State.NORMAL and i not in excl:
					i.pressed = true
					excl.append(self)
					i.reveal(excl, false)
		else:
			pressed = true
	else:
		sprite.animation = str(mines)
		if end:
			pressed = true

func check() -> int:
	var mines:int = 0
	for i in neigh:
		if i.tile_state == State.MINE:
			mines += 1
	return mines
