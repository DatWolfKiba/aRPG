class_name SaverLoader
extends Node
@onready var player: Player = $"../../Player"


# Called when the node enters the scene tree for the first time.
func save_game() -> void:
	var file = FileAccess.open("res://savegame.data", FileAccess.WRITE)
	file.store_var(player.global_position)
	file.close()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_game() -> void:
	var file = FileAccess.open("res://savegame.data", FileAccess.READ)
	player.global_position = file.get_var()
	file.close()
