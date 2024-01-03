extends Node3D

signal raycast_move(end: Vector3)
signal left_mouse_button_down(is_pressed: bool)
signal provide_position(pose:Vector3)
signal on_player_lose

@onready var camera = $Camera
@onready var surfer = $Surfer
@onready var kite = $Kite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cursor = camera.raycast_cursor_forward(5)
	camera.follow_point(Vector2(cursor.x, cursor.y), delta)
	emit_signal("raycast_move", cursor)
	
	var is_left_mouse_button_down = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	emit_signal("left_mouse_button_down", is_left_mouse_button_down)
	
	camera.global_position.z = surfer.global_position.z - 4.0
	kite.global_position = cursor


func _on_surfer_on_player_fail():
	on_player_lose.emit()


func _on_surfer_provide_position(position):
	provide_position.emit(position)
