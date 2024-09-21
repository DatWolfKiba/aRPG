class_name SaverLoader
extends Node
@onready var player: Player = $"../../Player"


# Called when the node enters the scene tree for the first time.
func save_game() -> void:
	var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	
	var saved_data = {}
	
	saved_data["player_position:x"] = player.global_position.x
	saved_data["player_position:y"] = player.global_position.y
	
	var json = JSON.stringify(saved_data)
	
	file.store_string(json)
	file.close()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_game() -> void:
	var file = FileAccess.open("user://savegame.json", FileAccess.READ)
	var json = file.get_as_text()
	
	var saved_data = JSON.parse_string(json)
	
	player.global_position.x = saved_data["player_position:x"] 
	player.global_position.y = saved_data["player_position:y"] 

	file.close()
