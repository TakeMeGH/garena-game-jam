extends Node

@export var gold : int = 0
var base_gold : int = 1
var multiplier_gold : float = 1.0

func add_gold():
	gold += ceil(base_gold * multiplier_gold)
