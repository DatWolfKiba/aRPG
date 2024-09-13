extends Camera2D

@export var tilemap: TileMap
@export var follow_node: Node2D

func _ready():

	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizeInPixels = mapRect.size * tileSize
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y
	
func _process(delta):
	global_position = follow_node.global_position
