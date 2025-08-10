extends Control


#TODO:
# - TopButton, UpperButton, BottumButton -> the values that are "filled" in these buttons should be the sum of the stats
# - "Equiped" variables
# - CHECK Have clothing buttons disabled at first -> populate with the clothing icons that are found
# - CHECK 3 ArrayLists with the clothing
# - Make category buttons clickable
# - Switch icons between buttons when changing clothing
# - Make the clothing panels correspond to the correct buttons (e.g. top cannot go with bottom)
# - Esc button

@onready var top_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer5/MarginContainer/TopGrid
@onready var upper_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer6/MarginContainer/UpperGrid
@onready var bottom_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer7/MarginContainer/BottomGrid

#Dictionary with clothing items pngs
var clothing_items = {
	"shirt": preload("res://scenes/assets/placeholderButtonDressUp.PNG"),
	"shirt2": preload("res://scenes/assets/placeholderButtonDressUp.PNG"),
	"glasses": preload("res://scenes/assets/placeholderGlasses.PNG"),
	"tie": preload("res://scenes/assets/placeholderTie.PNG"),
	"empty": preload("res://scenes/assets/placeholderButtonEmpty.PNG") #TODO: empty will prob not be here, but disabled instead
}

#ArrayLists for picked up clothing items, empty at start
var top_clothing: Array[String] = ["glasses"]
var upper_clothing: Array[String] = ["shirt", "tie", "shirt2", "shirt", "shirt", "shirt", "shirt", "shirt"]
var bottom_clothing: Array[String] = []

var selected_category: String = ""
var selected_item_index: int = -1 
var selected_button: TextureButton = null

signal _on_top_pressed

func _ready():
	
	#Disable all clothing buttons at the start
	for child in top_grid.get_children():
		if child is TextureButton:
			child.disabled = true
	for child in upper_grid.get_children():
		if child is TextureButton:
			child.disabled = true
	for child in bottom_grid.get_children():
		if child is TextureButton:
			child.disabled = true
	
	#TODO: remove these
	player_found_item("tie", "bottom")
	add_to_inventory_ui("upper")
	add_to_inventory_ui("top")


func player_found_item(item_id: String, category: String):
	match category:
		"top":
			top_clothing.append(item_id)
			add_to_inventory_ui("top")
		"upper":
			upper_clothing.append(item_id)
			add_to_inventory_ui("upper")
		"bottom":
			bottom_clothing.append(item_id)
			add_to_inventory_ui("bottom")

func add_to_inventory_ui(category: String):
	var items: Array[String]
	var container: GridContainer

	match category:
		"top":
			items = top_clothing
			container = top_grid
		"upper":
			items = upper_clothing
			container =  upper_grid
		"bottom":
			items = bottom_clothing
			container = bottom_grid

	# Update buttons for each category
	var buttons = container.get_children()
	for i in range(len(items)): #TODO: check that buttons are not out of range (should not happen though)
		if buttons[i] is TextureButton and buttons[i].disabled:
			buttons[i].texture_normal = clothing_items.get(items[i], clothing_items["empty"])
			buttons[i].disabled = false
			

func _on_top_button_pressed() -> void:
	selected_category = "top"
	selected_item_index = -1  
	%TextureButton._on_main_button_pressed()

func _on_upper_button_pressed() -> void:
	selected_category = "upper"
	selected_item_index = -1

func _on_bottom_button_pressed() -> void:
	selected_category = "bottom"
	selected_item_index = -1
