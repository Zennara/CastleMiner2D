extends Node2D

func _ready():
	if randi()%2 == 0:
		$TextureRect.texture = load("res://assets/items/axebloodstone.png")
	else:
		$TextureRect.texture = load("res://assets/items/bulletdiamond.png")
