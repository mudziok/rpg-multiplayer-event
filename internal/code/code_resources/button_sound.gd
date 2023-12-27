class_name ButtonSound
extends Button

@export_group("Sounds")
@export var on_click_sound: AudioStream
@export var on_hover_sound: AudioStream


func play_sound(sound: AudioStream):
	var audio_player = OneShotAudio.new(sound)
	GlobalSounds.add_child(audio_player)

func _on_pressed():
	play_sound(on_click_sound)

func _on_mouse_entered():
	play_sound(on_hover_sound)
