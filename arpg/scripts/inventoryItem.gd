extends Resource

class_name InventoryItem 

@export var name: String = ""
@export var texture: Texture2D  
@export var stackSize: int = 10
@export var maxAmountPrStack: int = 10

func use(player: Player) -> void:
	pass

func can_be_used(player: Player) -> bool:
	return true
