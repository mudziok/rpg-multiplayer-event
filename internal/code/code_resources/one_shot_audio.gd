class_name OneShotAudio
extends AudioStreamPlayer

func _init(sound_stream: AudioStream):
	if not sound_stream:
		printerr("Played empty sound!")
		self.queue_free()
	self.stream = sound_stream
	self.autoplay = true
	self.finished.connect(_on_finished)

func _on_finished():
	self.queue_free()
