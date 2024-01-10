extends Node

@export var red : float = 0.8
@export var green : float = 0.39
@export var blue : float = 0.59

@export var kite_color : Color = Color(red, green, blue)

func update_color():
	kite_color = Color(red, green, blue)
