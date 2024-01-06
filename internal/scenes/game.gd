extends Node3D

var time = 0.0
var minutes: int = 0
var seconds: int = 0
var distance: int = 0

var map_generator
var gameover_screen
var speedometer
var test
var file_name = "user://test_save.tres"
var bestDistance = 0
var bestTime = 0

func _ready():
	time = 0.0
	distance = 0
	map_generator = $map_controler
	gameover_screen = $GameOverScreen
	speedometer = $speedometer

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
	set_ui_invisible()
	gameover_screen.visible = true
	load_data()
	gameover_screen.game_over(speedometer.distanceTraveled, time, bestDistance, bestTime)
	if(speedometer.distanceTraveled > bestDistance):
		bestDistance = speedometer.distanceTraveled
	if(time > bestTime):
		bestTime = time
	save_data(bestDistance, bestTime)
	
func _on_land_mine_on_player_exploded():
	get_tree().change_scene_to_file("res://internal/code/main_screen.tscn")

func _on_player_provide_position(pose):
	distance = pose.z
	

func save_data(distance, time):
	var playerData = PlayerData.new()
	playerData.bestDistance = distance
	playerData.bestTime = time
	ResourceSaver.save(playerData, file_name)	
	
func load_data():
	if ResourceLoader.exists(file_name):
		var playerData = ResourceLoader.load(file_name)
		if playerData is PlayerData: # Check that the data is valid
			bestDistance = playerData.bestDistance
			bestTime = playerData.bestTime
	
func set_ui_invisible():
	speedometer.visible = false
	$TextTimeAlive.visible = false
	$Minutes.visible = false
	$Seconds.visible = false
	$UIBackground.visible = false

