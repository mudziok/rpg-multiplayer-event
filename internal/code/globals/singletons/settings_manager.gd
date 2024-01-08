extends Node

var file_name = "user://settings.tres"
var sound_bus = AudioServer.get_bus_index("Sound")
var music_bus = AudioServer.get_bus_index("Music")

func load_settings():
	if ResourceLoader.exists(file_name):
		var settings_data = ResourceLoader.load(file_name)
		if settings_data is SettingsData: # Check that the data is valid
			AudioServer.set_bus_volume_db(music_bus, settings_data.music_volume)
			AudioServer.set_bus_volume_db(sound_bus, settings_data.sound_volume)

func _save_settings():
	var settings_data = SettingsData.new()
	settings_data.music_volume = get_music_volume()
	settings_data.sound_volume = get_sound_volume()
	ResourceSaver.save(settings_data, file_name)

func set_music_volume(value):
	_set_music_volume(value)
	_save_settings()
	
func _set_music_volume(value):
	AudioServer.set_bus_volume_db(music_bus, value)
	
func get_music_volume():
	return AudioServer.get_bus_volume_db(music_bus)
	
func set_sound_volume(value):
	_set_music_volume(value)
	_save_settings()
	
func _set_sound_volume(value):
	AudioServer.set_bus_volume_db(sound_bus, value)
	
func get_sound_volume():
	return AudioServer.get_bus_volume_db(sound_bus)
