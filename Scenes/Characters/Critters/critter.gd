class_name Critter
extends CharacterBody2D

var _crop : CropCell
var cell : CritterCell
#TODO: Decide if one attack will destroy the crop
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

#FIXME: tweening is bad if we want to kick them away before they reach the crop
@onready var entry_tween : Tween = (
	func() -> Tween:
		var tween = create_tween()
		tween.tween_property(self, "global_position", _crop.global_position - Vector2(5, -5), 1)\
			.set_trans(Tween.TRANS_CUBIC)\
			.set_ease(Tween.EASE_OUT)
		tween.tween_callback(_arrival)
		tween.stop()
	
		return tween
).call()

#TODO: Check over creature _ready() function
func _ready() -> void:
	entry_tween.play()
	$Sprite2D.frame = randi_range(0, 9)

#TODO: Create check to cancel tween in the case plant gets harvested before reaching it
func _process(_delta: float) -> void:
	if _crop == null or not is_instance_valid(_crop):
		_leave()
	elif _crop.rotted:
		_leave()
	move_and_slide()

#TODO: Creature _arrival init
func _arrival() -> void:
	#HACK: I really don't like checking if instance is valid
	print_debug(is_instance_valid(_crop))
	if _crop == null or not is_instance_valid(_crop):
		_leave()
		return
	GM.critter_etml.target_crop(self, _crop)
	add_child(_attack_timer)

#TODO: Creature leave function
func _leave() -> void:
	_stop_attacking()
	take_damage(Vector2.RIGHT)

#TODO: Creature attack
func _attack() -> void:
	_handle_attack() #TODO: once attack animation is present bind it to animation
	_leave() #TODO: Wait for attack animation to finish before leaving

func _handle_attack() -> void:
	_stop_attacking()
	_crop.rot()
	
#TODO: Actual damage animation (send it to _leave function)
func take_damage(dir: Vector2) -> void:
	_stop_attacking()
	velocity = dir * 300

#TODO: Re-check this script, this function is called like 3 times for some reason
# Prolly bc of the half-baked solution atm
# Most likely happens when there is no crop to attack (2x)
func _stop_attacking() -> void:
	if _attack_timer == null or not is_instance_valid(_attack_timer):
		return
	_attack_timer.stop()
	#Temporary fix to avoid the error, upper todo is still a problem tho
	if _attack_timer.get_parent():
		remove_child(_attack_timer)
	_attack_timer.queue_free()

func set_crop(crop : CropCell) -> void:
	_crop = crop

#TODO: Time timeouts
