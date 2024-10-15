class_name StateMachine
extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

@onready var anim : AnimationPlayer = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_changed.connect(_on_change_state)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta : float) -> void:
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _on_change_state(state, s_new_state) -> void:
	if state != current_state:
		return
	
	var new_state = states[s_new_state.to_lower()]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
