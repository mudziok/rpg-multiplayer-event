extends PanelContainer

var sound_bus = AudioServer.get_bus_index("Sound")
var music_bus = AudioServer.get_bus_index("Music")

func _on_back_button_up():
	get_parent().remove_child(self)


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)


func _on_sound_value_changed(value):
	AudioServer.set_bus_volume_db(sound_bus, value)
