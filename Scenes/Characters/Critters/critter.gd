class_name Critter
extends CharacterBody2D

var _crop : CropCell
var cell : CritterCell

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var audio_player : Node = $AudioPlayer

var ps_target_line : PackedScene = preload("res://Scenes/Characters/Critters/target_line.tscn")

func _ready() -> void:
	$Sprite2D.frame = randi_range(0, 9)

func _process(delta: float) -> void:
	move_and_slide()
		
func take_damage(dir: Vector2) -> void:
	$StateMachine/attacking.take_damage(dir)

func set_crop(crop : CropCell) -> void:
	_crop = crop
