extends Node

var sounds: Dictionary = {}
signal finished(stream: AudioStreamPlayer)

func _ready() -> void:
	for child in get_children():
		if child is AudioStreamPlayer:
			sounds[child.name.to_lower()] = child
			child.finished.connect(finished.emit.bind(child))

func play(clip_name: String) -> void:
	if not sounds.has(clip_name):
		push_error("%s does not have a clip named '%s'" % [owner.name, clip_name])
		return
	
	sounds[clip_name.to_lower()].play()
