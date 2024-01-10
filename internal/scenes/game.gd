extends Node3D

var time = 0.0
var minutes: int = 0
var seconds: int = 0
var distance: int = 0

var map_generator
var gameover_screen
var speedometer
var test
var kite
var kite_material
var file_name = "user://test_save.tres"
var bestDistance = 0
var bestTime = 0

var great_text_variation = ['[center]GREAT![/center]', '[center]ZOOMING FAST![/center]', '[center]FAST BOI![/center]',
'[center]FASTER THAN A LIGHT![/center]', '[center]AAAAAAA![/center]']
var jump_text_variation = ['[center]NICE JUMP![/center]', '[center]FLYING HIIIIGH![/center]', '[center]IS IT BIRD OR PLANE?![/center]',
'[center]DONT TRY THIS AT HOME![/center]', '[center]LIKE A BIRD IN THE SKY[/center]']
var is_great_text_set = false
var is_jump_text_set = false
var growing_great_text = true
var growing_jump_text = true

func _ready():
	time = 0.0
	distance = 0
	map_generator = $map_controler
	gameover_screen = $GameOverScreen
	speedometer = $speedometer
	kite = $Player/Kite
	prepare_color_changing()

# update timer every milisecond
func update_score(delta):
	time += delta
	minutes = fmod(time, 3600) / 60
	seconds = fmod(time, 60)
	$Seconds.text = "%02d" % seconds

func _process(delta):
	change_kite_color()
	show_great_texts(delta)
	update_score(delta)

func _on_player_on_player_lose():
	#może po jakimś delayu?
	set_ui_invisible()
	gameover_screen.visible = true
	$ColorChangeScreen.visible = true
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
	$ColorChangeScreen.visible = false
	$GreatTextLabel.visible = false
	$NiceJumpLabel.visible = false
	
func prepare_color_changing():
	kite_material = kite.get_active_material(0)
	kite_material.albedo_color = CustomizationOptions.kite_color
	$ColorChangeScreen/ColorSliders/RedSlider.set_value(CustomizationOptions.red)
	$ColorChangeScreen/ColorSliders/GreenSlider.set_value(CustomizationOptions.green)
	$ColorChangeScreen/ColorSliders/BlueSlider.set_value(CustomizationOptions.blue)
	
func change_kite_color():
	CustomizationOptions.red = $ColorChangeScreen/ColorSliders/RedSlider.get_value()
	CustomizationOptions.green = $ColorChangeScreen/ColorSliders/GreenSlider.get_value()
	CustomizationOptions.blue = $ColorChangeScreen/ColorSliders/BlueSlider.get_value()
	CustomizationOptions.update_color()
	kite_material.albedo_color = CustomizationOptions.kite_color

func show_great_texts(delta):
	if speedometer.velocity > 5.0:
		if not is_great_text_set:
			$GreatTextLabel.scale = Vector2(1, 1)
			$GreatTextLabel.position = Vector2(randi() % 800 + 50, randi() % 550 + 50)
			$GreatTextLabel.clear()
			$GreatTextLabel.push_color(Color(randf(), randf(), randf()))
			$GreatTextLabel.append_text(great_text_variation[randi() % great_text_variation.size()])
			$GreatTextLabel.pop()
			$GreatTextLabel.visible = true
			is_great_text_set = true
			
		if growing_great_text:
			$GreatTextLabel.scale += Vector2(delta * 0.75, delta * 0.75)
		else:
			$GreatTextLabel.scale -= Vector2(delta * 0.75, delta * 0.75)
			
		if $GreatTextLabel.scale.x >= 1.5:
			growing_great_text = false
		elif $GreatTextLabel.scale.x <= 0.5:
			growing_great_text = true
	else:
		$GreatTextLabel.visible = false
		is_great_text_set = false
	if abs($Player/Surfer.velocity.y) > 0:
		if not is_jump_text_set:
			$NiceJumpLabel.scale = Vector2(1, 1)
			$NiceJumpLabel.position = Vector2(randi() % 800 + 50, randi() % 550 + 50)
			$NiceJumpLabel.clear()
			$NiceJumpLabel.push_color(Color(randf(), randf(), randf()))
			$NiceJumpLabel.append_text(jump_text_variation[randi() % jump_text_variation.size()] )
			$NiceJumpLabel.pop()
			$NiceJumpLabel.visible = true
			is_jump_text_set = true
		
		if growing_jump_text:
			$NiceJumpLabel.scale += Vector2(delta * 0.75, delta * 0.75)
		else:
			$NiceJumpLabel.scale -= Vector2(delta * 0.75, delta * 0.75)
			
		if $NiceJumpLabel.scale.x >= 1.5:
			growing_jump_text = false
		elif $NiceJumpLabel.scale.x <= 0.5:
			growing_jump_text = true
	else:
		$NiceJumpLabel.visible = false
		is_jump_text_set = false
	
