extends Node2D

@export var refresh_duration : float = 5

var crops : Dictionary = {
	"wheat" : preload("res://Scenes/Crop/crop.tscn")
}

var crop_pool : Array[String] = [
	"wheat"
]

func _ready() -> void:
	GM.shop_mgr = self
	
	# Make this listen to if any crops are bought
	call_deferred("_start_listening")

func _start_listening() -> void:
	var cells = owner.cells.values()
	print_debug(cells) 
	for cell : ShopCell in cells:
		cell.bought_crop.connect(_start_refresh)

func _start_refresh(cell : ShopCell) -> void:
	print_debug("Started shop refresh")
	var timer : Timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(func():
		_set_crop(cell)
		timer.queue_free()
		)
	add_child(timer)
	timer.start(refresh_duration)

#TODO: Test set_crop()
func _set_crop(cell : ShopCell) -> Cell:
	print_debug("Setting new crop to shop cell")
	# Create random cell from the current pool
	var crop : Crop = crops[crop_pool.pick_random()].instantiate()
	cell.set_crop(crop)
	return cell
