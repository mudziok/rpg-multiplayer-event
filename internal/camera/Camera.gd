extends Camera3D

const MAX_FOLLOW_OFFSET = 0.3
const CAMERA_FOLLOW_SPEED = 4.0

var current_fov: float = 70.0
@export var surfer : Node3D

func raycast_cursor_forward(distance: int):
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos.x = clamp(mouse_pos.x, 0, get_viewport().size.x)
	mouse_pos.y = clamp(mouse_pos.y, 0, get_viewport().size.y)
	return project_position(mouse_pos, distance)

func follow_point(cursor: Vector2, delta: float):
	var new_h_offset = (global_position.x - cursor.x) * MAX_FOLLOW_OFFSET
	cursor.y = max(cursor.y, -3)	#Prevents from looking into ground
	var new_v_offset = (cursor.y - global_position.y) * MAX_FOLLOW_OFFSET
	
	global_position = surfer.global_position - Vector3.FORWARD*3 + Vector3.UP * 2
	global_position.y = max(global_position.y, 2)
	h_offset = lerp(h_offset, new_h_offset, delta * CAMERA_FOLLOW_SPEED)
	v_offset = lerp(v_offset, new_v_offset, delta * CAMERA_FOLLOW_SPEED)

func _process(delta):
	fov = lerp(fov, current_fov, delta * 4.0)

func _on_player_left_mouse_button_down(is_pressed):
	if is_pressed:
		current_fov = 65
	else:
		current_fov = 75
