extends HBoxContainer

@onready var heartGuiClass = preload("res://scenes/heart_gui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMaxHearts(max: int):
	for i in range(max):
		var heart = heartGuiClass.instantiate()
		add_child(heart)

func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	for heart in range(currentHealth):
		hearts[heart].update(true)
		
	for heart in range (currentHealth, hearts.size()):
		hearts[heart].update(false)
