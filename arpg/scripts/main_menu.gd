extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn") # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
