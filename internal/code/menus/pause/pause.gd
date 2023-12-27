extends PanelContainer

func _enter_tree():
	get_tree().paused = true

func _exit_tree():
	get_tree().paused = false

func _on_back_button_up():
	get_parent().remove_child(self)
