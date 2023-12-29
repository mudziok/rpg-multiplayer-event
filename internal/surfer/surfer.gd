extends CharacterBody3D

signal provide_position(position :Vector3)

const ACCELERATION_Z = 3.0
const DEACCELERATION_Z = ACCELERATION_Z * 2.0

const ACCELERATION_X = 10.0
const ACCELERATION_Y = 20.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var attractor: Vector3 = Vector3(0.0, 0.0, 1.0)
var is_clinching: bool = false

func set_attractor(new_attractor: Vector3):
	attractor = new_attractor
	
func set_is_clinching(new_chlinching: bool):
	is_clinching = new_chlinching

func get_angle_to_attractor():
	# XD this 100% isnt correct some vfx artist smarter than me please fix
	return global_position.signed_angle_to(attractor, Vector3.FORWARD)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# speedup when on the ground
	if is_on_floor():
		velocity.z += ACCELERATION_Z * delta	
	
	var position_difference_x = attractor.x - global_position.x
	
	velocity.x = move_toward(velocity.x, position_difference_x, ACCELERATION_X)
	
	# slow down when flying on the kite
	if is_clinching:
		var position_difference_y = attractor.y - global_position.y
		velocity.y = move_toward(velocity.y, position_difference_y, ACCELERATION_Y)
		
		var min_velocity = min(velocity.z, 1.0)
		velocity.z = move_toward(velocity.z, min_velocity, DEACCELERATION_Z * delta)
	
	
	rotation.y = get_angle_to_attractor()
	
	move_and_slide()
	emit_signal("provide_position",position)
