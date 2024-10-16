extends Node

@export var initial_state : State
@export var animation_player : AnimationPlayer

var current_state : State
var states : Dictionary = {}	# This is used only for forced transitions


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_changed.connect(_on_change_state)
			if animation_player:
				child.anim = animation_player
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta : float) -> void:
	if current_state:
		current_state.update(delta)
	
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _on_change_state(state, new_state) -> void:
	if state != current_state:
		return
	
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state


func force_state_change(new_state : String) -> void:
	if not states.has(new_state):
		push_error("State '%s' does not exist!" % new_state)
		return
	
	var state = states[new_state]
	
	if not state:
		push_error("Failed to force state change to %s!" % new_state)
		return
	
	if current_state:
		current_state.exit()
	
	state.enter()
