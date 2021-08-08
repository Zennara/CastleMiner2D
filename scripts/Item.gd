extends Node2D

func _ready():
	if randi()%2 == 0:
		$TextureRect.texture = load("res://assets/items/Iron Sword.png")
	else:
		$TextureRect.texture = load("res://assets/items/Slime Potion.png")
