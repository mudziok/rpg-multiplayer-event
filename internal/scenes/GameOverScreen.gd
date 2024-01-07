extends Panel


var distanceText
var previousBestDistanceText
var minutesText
var secondsText
var previousBestTimeText

# Called when the node enters the scene tree for the first time.
func _ready():
	distanceText = $Distance
	previousBestDistanceText = $PreviousBestDistance
	minutesText = $Minutes
	secondsText = $Seconds
	previousBestTimeText = $PreviousBestTime

func game_over(distance, time, bestDistance, bestTime):
	distanceText.text = "%02.2f" % distance
	previousBestDistanceText.text = "best: %02.2f" % bestDistance
	
	var minutes = fmod(time, 3600) / 60
	var seconds = fmod(time, 60)
	minutesText.text = "%02d:" % minutes
	secondsText.text = "%02d" % seconds
	minutes = fmod(bestTime, 3600) / 60
	seconds = fmod(bestTime, 60)
	previousBestTimeText.text = "best: %02d:" % minutes + "%02d" % seconds

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://internal/code/main_screen.tscn")


func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://internal/scenes/game.tscn")
