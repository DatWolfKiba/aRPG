extends Panel

@onready var inventory: Inventory = preload("res://resources/playerInventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector

var currently_selected: int = 0

func _ready():
	update() 
	inventory.updated.connect(update)

func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
		
func _unhandled_input(event) -> void:
	if event.is_action_pressed("use_item"):
		inventory.use_item_at_index(currently_selected)
		
