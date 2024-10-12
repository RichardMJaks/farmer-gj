class_name Critter
extends CharacterBody2D

var crop : CropCell
#TODO: Decide if one attack will destroy the crop
var _attack_rate : float = 3
var _first_attack_delay : float = 5

@onready var anim : AnimationPlayer = $AnimationPlayer

@onready var entry_tween : Tween = _create_entry_tween()
func _create_entry_tween() -> Tween:
	var tween = create_tween()
	tween.tween_property(self, "position", crop.coords - Vector2(5, -5), 1)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(_arrival)
	tween.stop()
	
	return tween

#TODO: Check over creature _ready() function
func _ready() -> void:
	entry_tween.play()
	$Sprite2D.frame = randi_range(0, 9)

#TODO: Creature _process() function
func _process(_delta: float) -> void:
	pass

#TODO: Creature _arrival init
func _arrival() -> void:
	pass

#TODO: Creature leave function
func _leave() -> void:
	pass

#TODO: Creature attack
func _attack() -> void:
	pass
	
#TODO: Creature take damage
func take_damage(c : CharacterBody2D) -> void:
	pass


#TODO: Time timeouts
func _on_first_strike_timer_timeout() -> void:
	pass
func _on_expiration_timer_timeout() -> void:
	pass
