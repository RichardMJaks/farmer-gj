class_name State
extends Node

signal state_changed(state : State, s_new_state : String)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
