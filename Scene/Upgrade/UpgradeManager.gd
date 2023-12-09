extends Node2D

@export var upgrade_list : Array[AbilityUpgrade]
@onready var upgrade_ui : UpgradeUI = $"../UpgradeUI"
var upgrade_data : Dictionary

signal upgraded(upgrade_data:Dictionary)

func _ready():
	upgrade_ui.upgrade_selected.connect(_on_upgrade_selected)

func _process(delta):
	pass

func get_upgrade(num_of_upgrade):
	var temp_list : Array[AbilityUpgrade] = upgrade_list.duplicate()
	var result_list : Array[AbilityUpgrade]
	for i in range(num_of_upgrade):
		if temp_list.size() > 0:
			var random_result = temp_list.pick_random()
			temp_list.remove_at(temp_list.find(random_result))
			result_list.append(random_result)
	return result_list
	
func _on_upgrade_selected(upgrade : AbilityUpgrade):
	if(upgrade == null):
		return
	if(!upgrade_data.has(upgrade.id)):
		upgrade_data[upgrade.id] = 1
	else:
		upgrade_data[upgrade.id] += 1
	upgraded.emit(upgrade_data)
