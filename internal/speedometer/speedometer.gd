extends Control

signal provide_velocity(velocity: float)

var last_position:Vector3
var distanceTraveled: float = 0
var delta_time:float=0

func _process(delta):
	delta_time=delta;


func _on_player_provide_position(pose):
	var displace:Vector3 = last_position - pose
	last_position=pose
	displace.y=0
	var velocity = (displace.length_squared()/delta_time)
	distanceTraveled += displace.length_squared()
	$VelocityNumber.text = "Velocity: %02.2f" % velocity
	$DistanceTraveledNumber.text = "Distance traveled: %02.2f" % distanceTraveled
	provide_velocity.emit(velocity)
