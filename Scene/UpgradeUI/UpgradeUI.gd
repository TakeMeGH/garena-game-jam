extends CanvasLayer
class_name  UpgradeUI
@export var first_panel : PanelContainer
@export var second_panel : PanelContainer
@export var third_panel : PanelContainer

var is_first_panel_cc = true
var is_second_panel_cc = true
var is_third_panel_cc = true

signal upgrade_selected(upgrade : AbilityUpgrade)


	
func set_upgrade(upgrade_list : Array[AbilityUpgrade]):
	first_panel.set_info(upgrade_list[0])
	if(is_first_panel_cc):
		first_panel.selected.connect(on_upgrade_selected.bind(upgrade_list[0]))
		is_first_panel_cc = false
	else:
		first_panel.selected.disconnect(on_upgrade_selected)
		first_panel.selected.connect(on_upgrade_selected.bind(upgrade_list[0]))
		
	second_panel.set_info(upgrade_list[1])
	if(is_second_panel_cc):
		second_panel.selected.connect(on_upgrade_selected.bind(upgrade_list[1]))
		is_second_panel_cc = false
	else:
		second_panel.selected.disconnect(on_upgrade_selected)
		second_panel.selected.connect(on_upgrade_selected.bind(upgrade_list[1]))
	third_panel.set_info(upgrade_list[2])
	if(is_third_panel_cc):
		third_panel.selected.connect(on_upgrade_selected.bind(upgrade_list[2]))
		is_third_panel_cc = false
	else:
		third_panel.selected.disconnect(on_upgrade_selected)
		third_panel.selected.connect(on_upgrade_selected.bind(upgrade_list[2]))
			
func on_upgrade_selected(upgrade : AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	
