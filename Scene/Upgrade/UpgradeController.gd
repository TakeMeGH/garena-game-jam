extends Node2D

@onready var main_character : MainCharacter = $"../MainCharacter"
@onready var upgrade_manager = $"../UpgradeManager"

var upgraded_data
# Called when the node enters the scene tree for the first time.
func _ready():
	upgrade_manager.upgraded.connect(on_upgrade)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_upgrade(updated_data : Dictionary):
	upgraded_data = updated_data
	print(updated_data, "UPGRADED DATA")

