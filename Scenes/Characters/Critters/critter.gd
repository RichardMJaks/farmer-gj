class_name Critter
extends CharacterBody2D

var _crop : CropCell
var cell : CritterCell

var _attack_speed : float = 2
@onready var _attack_timer : Timer = (
	func() -> Timer:
		var timer = Timer.new()
		timer.wait_time = _attack_speed
		timer.one_shot = true
		timer.autostart = true
		timer.timeout.connect(_attack)
		return timer
).call()

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
	
	if not cell:
		_go_to_plant(delta)
		
	move_and_slide()


func _go_to_plant(delta) -> void:
	var duration = 2
	
	if total_time_elapsed / duration >= 1:
		_arrival()
		return
	
	var weight = total_time_elapsed / duration
	# Cubic interpolation to arrive
	global_position = starting_position.lerp(
		_crop.global_position,						# b					(target vector)
		-(weight * weight) + 2 * weight				# weight 			(how far up the curve)	
	)
	total_time_elapsed += delta

func _arrival() -> void:
	#HACK: I really don't like checking if instance is valid
	if _crop == null or not is_instance_valid(_crop):
		_leave()
		return
	GM.critter_etml.attack_crop(self, _crop)
	add_child(_attack_timer)

func _leave() -> void:
	audio_player.play("fly")
	velocity = Vector2.from_angle(randf() * 10) * 100
	
	if cell:
		cell._remove()
	left = true

func _attack() -> void:
	_handle_attack()

func _handle_attack() -> void:
	_crop.rot()
	
func take_damage(dir: Vector2) -> void:
	_stop_attacking()
	GM.critter_etml.targeted_crops.erase(_crop)
	velocity = dir * 300
	left = true
	anim.play("get_kicked")

func _stop_attacking() -> void:
	if _attack_timer == null or not is_instance_valid(_attack_timer):
		return
	_attack_timer.stop()
	#HACK: Temporary fix to avoid the error
	if _attack_timer.get_parent():
		remove_child(_attack_timer)
	_attack_timer.queue_free()

func set_crop(crop : CropCell) -> void:
	_crop = crop
