extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://internal/code/main_screen.tscn")


func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://internal/scenes/game.tscn")
