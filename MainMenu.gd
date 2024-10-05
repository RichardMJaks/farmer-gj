extends Control

func _ready():
	pass
	
func _process(delta):
	pass

func _on_PlayButton_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Stages/debug_scene.tscn')


func _on_OptionsButton_pressed() -> void:
	print('options')


func _on_CreditsButton_pressed() -> void:
	print('credits')
