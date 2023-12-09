extends Node2D

@export var upgrade_list : Array[AbilityUpgrade]

func _ready():
	pass



func _process(delta):
	pass

func get_upgrade(num_of_upgrade):
	var temp_list : Array[AbilityUpgrade] = upgrade_list
	var result_list : Array[AbilityUpgrade]
	for i in range(num_of_upgrade):
		if temp_list.size() > 0:
			var random_result = temp_list.pick_random()
			temp_list.remove_at(temp_list.find(random_result))
			result_list.append(random_result)
	return result_list
