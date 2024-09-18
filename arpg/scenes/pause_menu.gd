extends Control

@onready var main = $"../.."
@onready var saverLoader = $"../../Utilities/SaverLoader"

func _on_resume_pressed() -> void:
	main.pauseMenu()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_save_pressed() -> void:
	saverLoader.save_game()
	get_tree().quit()
