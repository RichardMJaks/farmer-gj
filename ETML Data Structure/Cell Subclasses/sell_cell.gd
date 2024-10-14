class_name SellCell
extends Cell

func get_type():
	return SellCell

func sell_crops() -> int:
	return GM.collect_coins()
