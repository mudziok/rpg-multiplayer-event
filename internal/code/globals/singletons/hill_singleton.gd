extends Node

var default_curvature = Vector2(0.0, -0.2)

func set_curvature(curvature: Vector2):
	RenderingServer.global_shader_parameter_set("x_axis", curvature.x);
	RenderingServer.global_shader_parameter_set("y_axis", curvature.y);

func _ready():
	set_curvature(default_curvature)
