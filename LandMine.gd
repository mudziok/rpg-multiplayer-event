extends Node3D

func _on_body_entered(body):
	print("this landmine just put you under ground :P")
	body.position.y=-50
