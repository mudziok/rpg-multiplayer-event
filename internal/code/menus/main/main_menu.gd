extends PanelContainer

func _on_start_button_up():
	get_tree().change_scene_to_file("res://internal/scenes/game.tscn")
	pass # Replace with function body.


func _on_settings_button_up():
	PopUpDisplay.call_scene(PopUpDisplay.SCENE.SETTINGS)


func _on_credits_button_up():
	PopUpDisplay.call_scene(PopUpDisplay.SCENE.CREDITS)


func _on_exit_button_up():
	if OS.has_feature("web"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		get_tree().quit()
