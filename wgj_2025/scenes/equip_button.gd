class_name EquipButton extends TextureButton

var is_main_button_pressed:bool

var dress_up_root_ui: DressUpUI
var selected_category:String
var related_item:ItemStats
var index = -1;

func set_related_item(item_to_set:ItemStats, indexInUI: int):
	related_item = item_to_set 
	index = indexInUI

func _on_main_button_pressed(caller: DressUpUI, category: String):
	selected_category = category
	is_main_button_pressed = true
	dress_up_root_ui = caller

func deselect() -> void: 
	is_main_button_pressed = false

func _pressed() -> void:
	print("what")
	if !is_main_button_pressed:
		return
	print("here")
	dress_up_root_ui.set_new_selected_item(related_item, selected_category, index)
	is_main_button_pressed = false
