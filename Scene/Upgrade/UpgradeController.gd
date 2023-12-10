extends Node2D

@onready var main_character : MainCharacter = $"../MainCharacter"
@onready var CoreGamePlay = $".."
@onready var upgrade_manager = $"../UpgradeManager"

var upgraded_data : Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_manager.upgraded.connect(on_upgrade)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_upgrade(updated_data : Dictionary):
	upgraded_data = updated_data

func set_main_character(new_main_character):
	main_character = new_main_character

func reset():
	for ability_id in upgraded_data:
		var count = upgraded_data[ability_id]
		
		if(ability_id == "dreamy_digestion"):
			CoreGamePlay.dream_upgrade(count)
		elif(ability_id == "satiety_serenade"):
			CoreGamePlay.hungry_base_value *= 85.0 / 100
		elif(ability_id == "swift_strides"):
			main_character.set_movement_speed(count)
		elif(ability_id == "aerial_ballet"):
			main_character.double_jump_enabled()
		elif(ability_id == "gold_revelry"):
			Gold.multiplier_gold *= 1.5
		elif(ability_id == "hunger_harmony"):
			CoreGamePlay.hungry_multiplier *= 1.5
		elif(ability_id == "sustenance_symphony"):
			main_character.extend_timer(count)


