class_name State
extends Node

var anim : AnimationPlayer
@warning_ignore("unused_signal")
signal state_changed(state : State, new_state : State)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
