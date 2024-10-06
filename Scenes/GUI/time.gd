extends Node2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var anim : AnimationPlayer = $AnimationPlayer

func set_frame(frame : int):
	sprite.frame = frame
	anim.speed_scale = frame + 1
	
