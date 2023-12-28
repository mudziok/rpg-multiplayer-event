extends Node3D

signal raycast_move(end: Vector3)
signal left_mouse_button_down(is_pressed: bool)
@onready var camera = $Camera
@onready var skier = $Skier
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
	
	camera.global_position.z = skier.global_position.z - 4.0
	kite.global_position = cursor
