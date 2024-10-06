extends Node

var state : String
@onready var anim : AnimationPlayer = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_state(v_state : String) -> void:
	if state == "kicking":
		return
	state = v_state

func set_state_none() -> void:
	state = "none"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if state == "kicking":
		anim.play("kick")
	match(state):
		"idle" :
			anim.play("idle")
		"walking" :
			anim.play("walking")
		
