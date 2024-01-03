extends Control

var last_position:Vector3
var delta_time:float=0

func _process(delta):
	delta_time=delta;


func _on_player_provide_position(pose):
	var displace:Vector3 = last_position - pose
	last_position=pose
	displace.y=0
	var velocity = (displace.length_squared()/delta_time)
	$VelocityNumber.text = "%03d:" % velocity
