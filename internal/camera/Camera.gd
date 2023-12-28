extends Camera3D


const MAX_FOLLOW_OFFSET = 0.3
const CAMERA_FOLLOW_SPEED = 4.0

var current_fov: float = 70.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func raycast_cursor_forward(distance: int):
	var mouse_pos = get_viewport().get_mouse_position()
	var origin = project_ray_origin(mouse_pos)
	var end = origin + project_ray_normal(mouse_pos) * distance
	
	return end

func follow_point(cursor: Vector2, delta: float):
	var new_h_offset = (global_position.x - cursor.x) * MAX_FOLLOW_OFFSET
	var new_v_offset = (cursor.y - global_position.y) * MAX_FOLLOW_OFFSET
	
	h_offset = lerp(h_offset, new_h_offset, delta * CAMERA_FOLLOW_SPEED)
	v_offset = lerp(v_offset, new_v_offset, delta * CAMERA_FOLLOW_SPEED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fov = lerp(fov, current_fov, delta * 4.0)

func _on_player_left_mouse_button_down(is_pressed):
	if is_pressed:
		current_fov = 65
	else:
		current_fov = 75
