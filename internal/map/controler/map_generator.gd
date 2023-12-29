extends Node3D

const GAP_WIDTH = 7
const CHANCE_TO_CREATE_GAP = 3

var ground_tiles_list : Array
var obstacle_list: Array
func load_obstacles():
	obstacle_list.append(preload("res://internal/map/obstacles/tree_obstacle.tscn"))
	
var offset_z = -20
	
func load_tiles():
	ground_tiles_list.append(preload("res://internal/map/map_tiles/ground_tile_default.tscn"))
	

	
func _ready():
	load_obstacles()
	load_tiles()
	
	generate_tile()
	
func generate_tile():
	
	var tile =  ground_tiles_list.pick_random().instantiate()
	add_obstacles(tile,randi() % 10)
	var chance_to_create_gap = randi()
	if(chance_to_create_gap%10 >10-CHANCE_TO_CREATE_GAP):
		offset_z+=GAP_WIDTH
	tile.position.z+=offset_z
	
	return tile
	



func add_obstacles(tile : ground_tile,count : int):
	var ground_colider : CollisionShape3D = tile.get_collider()
	var  size :Vector3 = ground_colider.shape.get_debug_mesh().get_aabb().size
	var x_bound = size.x;
	var z_bound = size.z;
	offset_z += z_bound
	
	for i in range(count):
		var obstacle_position = Vector3(randi()%100*x_bound/100,1,randi()%100*z_bound/100)
		var obstacle_instance = obstacle_list.pick_random().instantiate()
		obstacle_instance.position=obstacle_position - Vector3(x_bound/2,0,z_bound/2)
		tile.add_child(obstacle_instance)
	

# Called when the node enters the scene tree for the first time. Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
