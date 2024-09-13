class_name BaseScene extends Node


@onready var player: Player = $Player
@onready var enterance_markers: Node2D = $EnteranceMarkers
# Called when the node enters the scene tree for the first time.
func _ready():
	if scene_manager.player:
		if player:
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)  
	position_player()

func position_player() -> void:
	var last_scene = scene_manager.last_scene_name.to_lower().replace('_', '').replace(' ', '')
	if last_scene.is_empty():
		last_scene = "any"
	
	for enterance in enterance_markers.get_children():
		var enterance_name = enterance.name.to_lower().replace('_', '').replace(' ', '')
		
		if enterance is Marker2D and enterance_name == "any" or enterance_name == last_scene:
			player.global_position = enterance.global_position
