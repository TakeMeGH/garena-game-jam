extends Node2D

@export var list_cost : Array[int]
var current_level = 1

signal end_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_level_cost() -> int:
	return list_cost[current_level-1]

func is_upgrade_available(money : int):
	return money >= get_level_cost()

func pay(money : int):
	if(is_upgrade_available(money)):
		upgrade()
		if(current_level == 6):
			print("HAHAHHA")
			emit_signal("end_game")
#			get_tree().change_scene_to_file("res://Scene/FinishUI/finishUI.tscn")
#			reset_level()


func upgrade():
	Gold.gold -= get_level_cost()
	current_level += 1

func reset_level():
	TownHall.current_level = 1
	

