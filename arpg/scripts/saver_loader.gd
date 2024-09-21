class_name SaverLoader
extends Node
@onready var player: Player = $"../../Player"

func save_game() -> void:
	var file = FileAccess.open("user://savegame.data", FileAccess.WRITE)
	
	var saved_data = {}
	
	saved_data["player_position"] = player.global_position
	
	var json = JSON.stringify(saved_data)
	
	file.store_var(saved_data)
	file.close()

func load_game() -> void:
	var file = FileAccess.open("user://savegame.data", FileAccess.READ)

	var saved_data = file.get_var()
	
	player.global_position = saved_data["player_position"] 
	file.close()
