extends Control

@onready var tile_grid = $Window/VBoxContainer/game/GridContainer
@onready var window = $Window
var tile_obj = preload("res://Scenes/games/minesweeper_tile.tscn")
var minesweeper = preload("res://Scenes/games/minesweeper.tscn")
var field = {}

#DIfficulty or in other word how many rows x collumns. Cannot be higher than 25
var dif = 25.0
var bombs = 0

# Generates the minefield and creates a list of neighbours for each tile
func _ready() -> void:
	tile_grid.columns = dif
	#Generation of the field
	for i in dif:
		var row = []
		for j in dif:
			var obj = tile_obj.instantiate()
			obj.dif = dif
			obj.game_over.connect(_on_game_over)
			obj.click.connect(_on_click)
			tile_grid.add_child(obj)
			row.append(obj)
		field["row_" + str(int(i)+1)] = row
	# generating list of neighbour tiles
	for row in field:
		for tile in field[row]:
			if tile.tile_state == Tile.State.MINE:
				bombs += 1
			var item_ind = field[row].find(tile)
			# If it's the first row
			if row == "row_1":
				var next_row = field["row_" + str(int(row.split("_")[1]) + 1)]
				# if it's the first item in the row
				if item_ind == 0:
					tile.neigh.append(field[row][item_ind+1])
					tile.neigh.append(next_row[item_ind])
					tile.neigh.append(next_row[item_ind+1])
				# if it's the last item in a row
				elif item_ind == field[row].size() - 1:
					tile.neigh.append(field[row][item_ind-1])
					tile.neigh.append(next_row[item_ind])
					tile.neigh.append(next_row[item_ind-1])
				# if it's neither
				else:
					tile.neigh.append(field[row][item_ind-1])
					tile.neigh.append(field[row][item_ind+1])
					tile.neigh.append(next_row[item_ind])
					tile.neigh.append(next_row[item_ind+1])
					tile.neigh.append(next_row[item_ind-1])
			# If it's the last row
			elif row == "row_" + str(int(dif)):
				var prev_row = field["row_" + str(int(row.split("_")[1]) - 1)]
				#First Tile
				if item_ind == 0:
					tile.neigh.append(field[row][item_ind+1])
					tile.neigh.append(prev_row[item_ind])
					tile.neigh.append(prev_row[item_ind+1])
				# Last Tile
				elif item_ind == field[row].size() - 1:
					tile.neigh.append(field[row][item_ind-1])
					tile.neigh.append(prev_row[item_ind])
					tile.neigh.append(prev_row[item_ind-1])
				#Tile In between
				else:
					tile.neigh.append(field[row][item_ind-1])
					tile.neigh.append(field[row][item_ind+1])
					tile.neigh.append(prev_row[item_ind])
					tile.neigh.append(prev_row[item_ind+1])
					tile.neigh.append(prev_row[item_ind-1])
			# Row in between
			else:
				var prev_row = field["row_" + str(int(row.split("_")[1]) - 1)]
				var next_row = field["row_" + str(int(row.split("_")[1]) + 1)]
				# first Tile
				if item_ind == 0:
					tile.neigh.append(field[row][item_ind+1])
					tile.neigh.append(prev_row[item_ind])
					tile.neigh.append(prev_row[item_ind+1])
					tile.neigh.append(next_row[item_ind])
					tile.neigh.append(next_row[item_ind+1])
				#Last Tile
				elif item_ind == field[row].size() - 1:
					tile.neigh.append(field[row][item_ind-1])
					tile.neigh.append(prev_row[item_ind])
					tile.neigh.append(prev_row[item_ind-1])
					tile.neigh.append(next_row[item_ind])
					tile.neigh.append(next_row[item_ind-1])
				#Row In between
				else:
					tile.neigh.append(field[row][item_ind-1])
					tile.neigh.append(field[row][item_ind+1])
					tile.neigh.append(prev_row[item_ind])
					tile.neigh.append(prev_row[item_ind+1])
					tile.neigh.append(prev_row[item_ind-1])
					tile.neigh.append(next_row[item_ind])
					tile.neigh.append(next_row[item_ind+1])
					tile.neigh.append(next_row[item_ind-1])
	$Window/VBoxContainer/menu/HBoxContainer/Label.text = str(bombs)
# Is emitted if a mine tile is clicked
func _on_game_over():
	var excl = []
	for row in field:
		for tile in field[row]:
			excl.append(tile)
			tile.reveal(excl, true)
	$Timer.start()
	$AudioStreamPlayer2D.play()
# Sees if victory conditions are met if a tile is clicked
func _on_click(click):
	var x = 0
	if click == "right":
		bombs -= 1
	elif click == "none":
		bombs += 1
	$Window/VBoxContainer/menu/HBoxContainer/Label.text = str(bombs)
	for row in field:
		for tile in field[row]:
			if tile.tile_state == Tile.State.MINE and tile.sprite.animation != "flag":
				x += 1
				print("Jup")
	if x == 0:
		$Window/Label.text = "You Won"
		$Window/Label.show()
		Gamemaster.flags.append("minesweeper")
		$Timer.start()
# Handles restart button
func _on_button_pressed() -> void:
	var obj = minesweeper.instantiate()
	add_sibling(obj)
	queue_free()
# For spacing
func _on_timer_timeout() -> void:
	queue_free()

func _process(_delta: float) -> void:
	$bounce.global_position = Vector2($Window.position.x + $Window.size.x / 2.0, $Window.position.y + $Window.size.y / 2.0 - 11)
