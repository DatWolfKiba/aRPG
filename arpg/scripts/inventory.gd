extends Resource

class_name Inventory 

signal updated

@export var slots: Array[InventorySlot] 

func insert(item: InventoryItem):
	for slot in slots:

		if slot.item == item && slot.amount < item.maxAmountPrStack:

			slot.amount += 1

			updated.emit()

			return

	

	for i in range(slots.size()):

		if !slots[i].item:

			slots[i].item = item

			slots[i].amount = 1

			updated.emit()

			return
	
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0]. amount +=1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
		 
	updated.emit()		


func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot
