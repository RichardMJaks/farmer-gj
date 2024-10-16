class_name Critter
extends CharacterBody2D

var _crop : CropCell
var cell : CritterCell

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var audio_player : Node = $AudioPlayer

var left : bool = false

var starting_position : Vector2
var total_time_elapsed : float = 0
#tweening is bad if we want to kick them away before they reach the crop
#currently leaving it just in case
#@onready var entry_tween : Tween = (
	#func() -> Tween:
		#var tween = create_tween()
		#tween.tween_property(self, "global_position", _crop.global_position - Vector2(5, -5), 1)\
			#.set_trans(Tween.TRANS_CUBIC)\
			#.set_ease(Tween.EASE_OUT)
		#tween.tween_callback(_arrival)
		#tween.stop()
	#
		#return tween
#).call()

var ps_target_line : PackedScene = preload("res://Scenes/Characters/Critters/target_line.tscn")

func _ready() -> void:
	starting_position = global_position
	#entry_tween.play()
	$Sprite2D.frame = randi_range(0, 9)
	audio_player.play("screech")
	_create_targeting_line()
	
func _create_targeting_line() -> void:
	var tl = ps_target_line.instantiate()
	tl.critter = self
	tl.crop = _crop
	GM.critter_etml.add_child(tl)

func _process(delta: float) -> void:
	if left:
		if global_position.length() > 250:
			queue_free()
			return
		move_and_slide()
		return
	
	if _crop == null or not is_instance_valid(_crop) or _crop.rotted:
		_stop_attacking()
		_leave()
		move_and_slide()
		return
		
	move_and_slide()

func _leave() -> void:
	audio_player.play("fly")
	velocity = Vector2.from_angle(randf() * 10) * 100
	
	if cell:
		cell._remove()
	left = true
	
func take_damage(dir: Vector2) -> void:
	_stop_attacking()

func set_crop(crop : CropCell) -> void:
	_crop = crop
