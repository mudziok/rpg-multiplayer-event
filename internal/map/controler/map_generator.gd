extends Node3D

const GAP_WIDTH = 7
const CHANCE_TO_CREATE_GAP = 3

var ground_tiles_list : Array
	
var offset_z = -20
	
func load_tiles():
	ground_tiles_list.append(preload("res://internal/map/map_tiles/ground_tile_default.tscn"))
	
	
func _ready():
	load_tiles()	
	
func generate_tile(player_position_z):
	
	var tile =  ground_tiles_list.pick_random().instantiate()
	offset_z+=tile.get_collider_size().z
	tile.populate_tile(player_position_z)
	var chance_to_create_gap = randi()
	if(chance_to_create_gap%10 >10-CHANCE_TO_CREATE_GAP and offset_z>30):
		offset_z+=GAP_WIDTH
	tile.position.z+=offset_z
	
	return tile
	
