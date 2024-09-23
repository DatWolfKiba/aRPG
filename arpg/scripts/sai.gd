extends Area2D

@onready var shape = $CollisionShape2D

func enable():
	shape.disabled = false
	
func disable():
	shape.disabled = true	





func _on_area_entered(area: Area2D) -> void:
	if area.name == "Boss":  # Assuming your boss node has the name "Boss"
		print("Boss hit by weapon!")
		area.take_damage()  # Call the boss's take_damage function
