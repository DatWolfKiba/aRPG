extends Node2D

@onready var heartContainer = $CanvasLayer/heartContainer
@onready var player = $Player

func _ready() -> void:
	heartContainer.setMaxHearts(player.maxHealth)
	heartContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartContainer.updateHearts)
