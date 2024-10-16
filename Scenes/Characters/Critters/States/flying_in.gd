extends State

@export var attacking : State
@export var flying_away : State

var ps_target_line : PackedScene = preload("res://Scenes/Characters/Critters/target_line.tscn")
var starting_position : Vector2
var total_time_elapsed : float = 0

func _create_targeting_line() -> void:
	var tl = ps_target_line.instantiate()
	tl.critter = char
	tl.crop = char._crop
	GM.critter_etml.add_child(tl)

func _go_to_plant(delta) -> void:
	var duration = 2
	
	if total_time_elapsed / duration >= 1:
		state_changed.emit(self, attacking)
		return
	
	var weight = total_time_elapsed / duration
	# Cubic interpolation to arrive
	if not char._crop:
		return
	char.global_position = starting_position.lerp(
		char._crop.global_position,
		-(weight * weight) + 2 * weight
	)
	total_time_elapsed += delta

func enter() -> void:
	starting_position = char.global_position
	#entry_tween.play()
	audio_player.play("screech")
	_create_targeting_line()

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if char._crop == null\
	  or not is_instance_valid(char._crop)\
	  or char._crop.rotted:
		state_changed.emit(self, flying_away)

func physics_update(delta: float) -> void:
	_go_to_plant(delta)
