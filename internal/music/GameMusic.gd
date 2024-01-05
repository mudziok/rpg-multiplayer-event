extends AudioStreamPlayer

var min_velocity = 5.0
var max_velocity = 30.0
var min_pitch_scale = 0.75
var max_pitch_scale = 1.5

func _on_speedometer_provide_velocity(velocity):
	var il = inverse_lerp(min_velocity, max_velocity, velocity)
	il = clamp(il, 0.001, 1)
	pitch_scale = lerp(min_pitch_scale, max_pitch_scale, il)
