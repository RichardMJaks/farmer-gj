extends Node2D

var indicators : Dictionary = {}
var active_indicator : Indicator
var attacked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Indicator:
			indicators[child.name.to_lower()] = child
			child.visible = false


func change_indicator(name : String) -> void:
	if name == "stop":
		if active_indicator:
			active_indicator.exit()
		active_indicator = null
		
	if attacked:
		return
	
	if not indicators.has(name):
		return
	
	if active_indicator:
		active_indicator.exit()
	
	active_indicator = indicators[name]
	active_indicator.enter()
		
func _process(delta: float) -> void:
	if active_indicator:
		active_indicator.update()
