extends Node

@export var gold : int = 0
var base_gold : int = 1
var multiplier_gold : int = 1

func add_gold():
	gold += base_gold * multiplier_gold
