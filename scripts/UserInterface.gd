extends CanvasLayer

func _input(event):
	if event.is_action_pressed("openinv"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()
