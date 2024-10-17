extends State	

@export var flying_away : State
@export var getting_kicked : State

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

func _attack() -> void:
	anim.play("hit")

func _handle_attack() -> void:
	if char._crop == null or not is_instance_valid(char._crop):
		state_changed.emit(self, flying_away)
		return
	char._crop.rot()
	state_changed.emit(self, flying_away)

func take_damage(dir : Vector2) -> void:
	getting_kicked.dir = dir
	state_changed.emit(self, getting_kicked)

func _leave() -> void:
	state_changed.emit(self, getting_kicked)

func enter() -> void:
	#HACK: I really don't like checking if instance is valid
	if char._crop == null or not is_instance_valid(char._crop):
		state_changed.emit(self, flying_away)
		return
	GM.critter_etml.attack_crop(char, char._crop)
	add_child(_attack_timer)
	char._crop.get_crop().indicator_handler.change_indicator("attacked")
	char._crop.get_crop().attacked = true

func exit() -> void:
	if _attack_timer == null or not is_instance_valid(_attack_timer):
		return
	_attack_timer.stop()
	#HACK: Temporary fix to avoid the error
	if _attack_timer.get_parent():
		remove_child(_attack_timer)
	_attack_timer.queue_free()
	char._crop.get_crop().attacked = false
	char._crop.get_crop().indicator_handler.change_indicator("stop")

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
