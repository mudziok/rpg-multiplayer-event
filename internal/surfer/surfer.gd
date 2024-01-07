extends CharacterBody3D

signal provide_position(position :Vector3)
signal on_player_fail

const ACCELERATION = Vector3(10, 250, 5)
const AIR_ACCELERATION_Z_MULTIPLIER = 0.1
const DECELERATION_Z = ACCELERATION.z * 2.0
const SPEED_X = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var attractor: Vector3 = Vector3(0.0, 0.0, 1.0)
var is_clinching: bool = false

func set_attractor(new_attractor: Vector3):
	attractor = new_attractor
	
func set_is_clinching(new_chlinching: bool):
	is_clinching = new_chlinching

func _physics_process(delta):
	var vec_to_attractor = (attractor - global_position).normalized()
	
	if is_on_floor():
		velocity.z += vec_to_attractor.z * ACCELERATION.z * delta
	else:
		velocity.z += vec_to_attractor.z * ACCELERATION.z * delta * AIR_ACCELERATION_Z_MULTIPLIER
		velocity.y -= gravity * delta
	
	# use move_toward for more "responsive" movement
	velocity.x = move_toward(velocity.x, vec_to_attractor.x * SPEED_X, ACCELERATION.x * delta)
	
	if is_clinching:
		# only allow flying up if you have some forward velocity
		if velocity.z > 0.1:
			velocity.y = (vec_to_attractor.y + 0.2) * ACCELERATION.y * delta
		
		# slow down when flying on the kite
		velocity.z -= DECELERATION_Z * delta
		velocity.z = max(velocity.z, 0)
		
	# model has forward in -z or smth, i cba
	var squashed_vec_to_attractor = Vector3(vec_to_attractor.x, 0, vec_to_attractor.z)
	quaternion = Quaternion(-Vector3.FORWARD, squashed_vec_to_attractor)
	
	move_and_slide()
	emit_signal("provide_position",position)
	
	#game over when fall
	if position.y < -20:
		on_player_fail.emit()
		
