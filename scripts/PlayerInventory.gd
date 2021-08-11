extends Node

const NUM_INVENTORY_SLOTS = 28

var inventory = {
	0: ["Bloodstone Axe", 1] #--> slot_index: [item_name, item_quantity]
}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			#TODO: check if slot is full
			inventory[item][1] += item_quantity
			return
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return
