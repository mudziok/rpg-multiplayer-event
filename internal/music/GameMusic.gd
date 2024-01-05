extends AudioStreamPlayer

func _on_speedometer_provide_velocity(velocity):
	pitch_scale = clamp((velocity / 10) - 0.25, 0.75, 1.5)
