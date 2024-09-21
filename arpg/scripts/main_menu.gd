extends Control

# Preload the world scene (which contains the SaverLoader)
var SaverLoaderScene: PackedScene = preload("res://scenes/world.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_load_pressed() -> void:
	# Instance the world scene (which contains SaverLoader)
	var world = SaverLoaderScene.instantiate()  # Use instantiate() instead of instance()
	get_tree().root.add_child(world)  # Add the world to the scene tree
	
	# Find the SaverLoader node in the world scene
	var saverLoader = world.get_node("Utilities/SaverLoader")
	
	if saverLoader != null:
		saverLoader.load_game()
		queue_free() 
	else:
		print("SaverLoader not found!")
