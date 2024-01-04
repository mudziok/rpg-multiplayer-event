extends Node3D

var time = 0.0
var minutes: int = 0
var seconds: int = 0
var distance: int = 0

var map_generator

func _ready():
	time = 0.0
	distance = 0
	map_generator = $map_controler

# update timer every milisecond
func update_score(delta):
	time += delta
	minutes = fmod(time, 3600) / 60
	seconds = fmod(time, 60)
	$Seconds.text = "%02d" % seconds

func _process(delta):
	update_score(delta)
	
	
func _on_player_on_player_lose():
	#może po jakimś delayu?
	get_tree().change_scene_to_file("res://internal/code/main_screen.tscn")
	
func _on_land_mine_on_player_exploded():
	get_tree().change_scene_to_file("res://internal/code/main_screen.tscn")

func _on_player_provide_position(pose):
	distance = pose.z
	
