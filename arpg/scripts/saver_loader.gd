class_name SaverLoader
extends Node
@onready var player: Player = $"../../Player"

func save_game() -> void:	
	var saved_game:SavedGame = SavedGame.new()
	saved_game.player_position = player.global_position 
	saved_game.player_health = player.currentHealth
		
	ResourceSaver.save(saved_game, "user://savegame.tres")
func load_game() -> void:
	var saved_game: SavedGame = load("user://savegame.tres") as SavedGame

	if saved_game:
		player.global_position = saved_game.player_position
		player.currentHealth = saved_game.player_health
		player.emit_signal("healthChanged", player.currentHealth)  # Update the health in the GUI
