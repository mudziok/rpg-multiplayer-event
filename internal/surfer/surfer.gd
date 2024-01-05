extends CharacterBody3D

signal provide_position(position :Vector3)
signal on_player_fail

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
	
func update_rotation():
	var squashed_attractor = Vector3(attractor.x, global_position.y, attractor.z)
	look_at(squashed_attractor)
	rotation_degrees.y += 180

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
	
	
	update_rotation()
	
	move_and_slide()
	emit_signal("provide_position",position)
	
	#game over when fall
	if position.y<-100:
		on_player_fail.emit()
		
