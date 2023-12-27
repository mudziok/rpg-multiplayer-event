extends PanelContainer



func _on_back_button_up():
	get_parent().remove_child(self)

