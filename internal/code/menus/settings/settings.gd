extends PanelContainer

@onready var settings = get_node("/root/SettingsManager")

func _on_back_button_up():
	get_parent().remove_child(self)

func _on_music_value_changed(value):
	settings.set_music_volume(value)

func _on_sound_value_changed(value):
	settings.set_sound_volume(value)

func _on_ready():
	var music_slider = $VBoxContainer/Music/Music
	music_slider.value = settings.get_music_volume()
	var sound_slider = $VBoxContainer/Sound/Sound
	sound_slider.value = settings.get_sound_volume()
