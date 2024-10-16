extends State

@export var attacking : State
@export var flying_away : State

var ps_target_line : PackedScene = preload("res://Scenes/Characters/Critters/target_line.tscn")
var starting_position : Vector2
var total_time_elapsed : float = 0

func _create_targeting_line() -> void:
	var tl = ps_target_line.instantiate()
	tl.critter = self
	tl.crop = owner._crop
	GM.critter_etml.add_child(tl)

func _go_to_plant(delta) -> void:
	var duration = 2
	
	if total_time_elapsed / duration >= 1:
		state_changed.emit(self, attacking)
		return
	
	var weight = total_time_elapsed / duration
	# Cubic interpolation to arrive
	owner.global_position = starting_position.lerp(
		owner._crop.global_position,
		-(weight * weight) + 2 * weight
	)
	total_time_elapsed += delta

func enter() -> void:
	starting_position = owner.global_position
	#entry_tween.play()
	$Sprite2D.frame = randi_range(0, 9)
	owner.audio_player.play("screech")
	_create_targeting_line()

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if owner._crop == null\
	  or not is_instance_valid(owner._crop)\
	  or owner._crop.rotted:
		state_changed.emit(self, flying_away)

func physics_update(delta: float) -> void:
	_go_to_plant(delta)
