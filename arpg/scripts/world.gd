extends BaseScene

@onready var heartContainer = $CanvasLayer/heartContainer
@onready var camera = $follow_cam
@onready var pause_menu = $CanvasLayer/PauseMenu

var paused = false

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

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else: 
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused  
