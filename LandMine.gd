extends Node3D

signal player_exploded

func _on_body_entered(body):
	#print("this landmine just put you under ground :P")
	print("this landmine put you in the sky and killed you, maybe explosion?")
	body.position.y=+30
	# this signal doesn't work at all, but it should force game to end
	player_exploded.emit()
	
	
