extends Node3D

var time = 0.0
var minutes: int = 0
var seconds: int = 0
var score: int = 0

func _ready():
	time = 0.0
	score = 0

# update timer every milisecond
func update_score(delta):
	time += delta
	minutes = fmod(time, 3600) / 60
	seconds = fmod(time, 60)
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d" % seconds

func _process(delta):
	update_score(delta)
