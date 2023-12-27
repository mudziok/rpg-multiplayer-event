extends PanelContainer


func _on_button_sound_button_down():
	get_parent().remove_child(self)


func _on_back_button_up():
	get_parent().remove_child(self)
