extends BaseScene

@onready var heartContainer = $CanvasLayer/heartContainer
@onready var camera = $follow_cam

func _ready():
	super()
	camera.follow_node = player
	
	heartContainer.setMaxHearts(player.maxHealth)
	heartContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartContainer.updateHearts)

func _on_inventory_gui_opened():
	get_tree().paused = true

func _on_inventory_gui_closed():
	get_tree().paused = false
