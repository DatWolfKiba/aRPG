extends Control

signal opened
signal closed

var isOpen: bool = false 

@onready var inventory: Inventory = preload("res://resources/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children() 

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	
func connectSlots():
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
	
func onSlotClicked(slot):
	pass
