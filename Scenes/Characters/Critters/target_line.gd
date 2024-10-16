extends Line2D

var critter : Critter
var critter_point: int = 0
var crop : CropCell
var crop_pos: Vector2
var crop_point : int = 1

var t: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_points()
	if critter:
		add_point(critter.global_position, critter_point)
	if crop:
		crop_pos = crop.global_position
		add_point(critter.global_position, crop_point)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if critter != null or is_instance_valid(critter):
		set_point_position(critter_point, critter.global_position)
	
	var pos: Vector2 = get_point_position(crop_point)
		
	if pos.is_equal_approx(crop_pos):
		return
	var weight = (0.3 * t)/(1 - t)
	set_point_position(crop_point, pos.lerp(crop_pos, weight))
	t += delta
