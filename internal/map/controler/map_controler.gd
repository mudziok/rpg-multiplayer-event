extends Node3D


# Called when the node enters the scene tree for the first time.
@onready var  map_generator = $map_generator
var player_position :Vector3
var map: Array[ground_tile]
func remove_tiles_behind():
	var tile = map[0]
	
	if(tile.position.z < player_position.z - 30 ):
		map.erase(tile)
		tile.free()
	
	

func _ready():
	for i in range(15):
		var tile = map_generator.generate_tile()
		map.append(tile)
		add_child(tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	remove_tiles_behind()
	if(map.size() < 15):
		var tile = map_generator.generate_tile()
		map.append(tile)
		add_child(tile)
		


func _on_surfer_provide_position(position):

	player_position =position
