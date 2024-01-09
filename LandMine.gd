extends Node3D

signal player_exploded

func _on_body_entered(body):
	# check if body has velocity so we are not exploding trees anymore
	if "velocity" in body:
		print("this landmine put you in the sky and killed you, maybe explosion?")
		body.velocity.y += 20
	# this signal doesn't work at all, but it should force game to end
	# maybe it's better this way?
	# yes
	player_exploded.emit()
