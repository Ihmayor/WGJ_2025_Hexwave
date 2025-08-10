class_name DressUpUI extends Control

@export var PlayerData: PlayerStats

#TODO:
# - TopButton, UpperButton, BottumButton -> the values that are "filled" in these buttons should be the sum of the stats
# - "Equiped" variables
# - CHECK Have clothing buttons disabled at first -> populate with the clothing icons that are found
# - CHECK 3 ArrayLists with the clothing
# - Make category buttons clickable
# - Switch icons between buttons when changing clothing
# - Make the clothing panels correspond to the correct buttons (e.g. top cannot go with bottom)

@onready var top_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer5/MarginContainer/TopGrid
@onready var upper_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer6/MarginContainer/UpperGrid
@onready var bottom_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer7/MarginContainer/BottomGrid

signal disable_selection_press

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

var current_inventory_amount: int


func _ready():
	current_inventory_amount = PlayerData.current_inventory.size()
	
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
	#player_found_item("tie", "bottom")
	#add_to_inventory_ui("upper")
	#add_to_inventory_ui("top")

func _physics_process(delta: float) -> void:
	#Check if Player Data has new items
	if current_inventory_amount < PlayerData.current_inventory.size():
		current_inventory_amount +=1
		var found_item:ItemStats = PlayerData.current_inventory.back()
		print(found_item.resource_path)
		player_found_item(found_item.resource_path, found_item.item_location)

func player_found_item(item_id: String, category: String):
	print("triggered player found item")
	print(item_id)
	print(category)
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
	var items: Array[ItemStats]
	var container: GridContainer
	print("player_found_item, category")
	print(category)
	match category:
		"top":
			items = PlayerData.current_inventory.filter(func(n): return n.item_location == "top")
			container = top_grid
		"upper":
			items = PlayerData.current_inventory.filter(func(n): return n.item_location == "upper")
			container =  upper_grid
			print(items)
		"bottom":
			items = PlayerData.current_inventory.filter(func(n): return n.item_location == "bottom")
			container = bottom_grid

	# Update buttons for each category
	var buttons = container.get_children()
	print(items.size())
	print("Current Inventory:")
	print(PlayerData.current_inventory.get(0).item_location)
	for i in range(len(items)): #TODO: check that buttons are not out of range (should not happen though)
		if buttons[i] is TextureButton and buttons[i].disabled:
			print(items[i])
			buttons[i].texture_normal = ResourceLoader.load(items[i].icon_for_item)
			#Tell the buttons what stat they're connected with
			if buttons[i] is EquipButton:
				(buttons[i] as EquipButton).set_related_item(items[i], i)
				disable_selection_press.connect((buttons[i] as EquipButton).deselect)
			buttons[i].disabled = false
			

func _on_top_button_pressed() -> void:
	selected_category = "top"
	selected_item_index = -1  
	#Hook up top buttons with the buttons in their column 
	%TextureButton._on_main_button_pressed(self, selected_category)
	%TextureButton2._on_main_button_pressed(self, selected_category)
	%TextureButton3._on_main_button_pressed(self, selected_category)
	%TextureButton4._on_main_button_pressed(self, selected_category)
	%TextureButton5._on_main_button_pressed(self, selected_category)
	%TextureButton6._on_main_button_pressed(self, selected_category)
	%TextureButton7._on_main_button_pressed(self, selected_category)
	%TextureButton8._on_main_button_pressed(self, selected_category)

func _on_upper_button_pressed() -> void:
	selected_category = "upper"
	selected_item_index = -1

	#Hook up top buttons with the buttons in their column 
	%UpperTextureButton._on_main_button_pressed(self, selected_category)
	%UpperTextureButton2._on_main_button_pressed(self, selected_category)
	%UpperTextureButton3._on_main_button_pressed(self, selected_category)
	%UpperTextureButton4._on_main_button_pressed(self, selected_category)
	%UpperTextureButton5._on_main_button_pressed(self, selected_category)
	%UpperTextureButton6._on_main_button_pressed(self, selected_category)
	%UpperTextureButton7._on_main_button_pressed(self, selected_category)
	%UpperTextureButton8._on_main_button_pressed(self, selected_category)

func _on_bottom_button_pressed() -> void:
	selected_category = "bottom"
	selected_item_index = -1

	#Hook up top buttons with the buttons in their column 
	%BottomTextureButton._on_main_button_pressed(self, selected_category)
	%BottomTextureButton2._on_main_button_pressed(self, selected_category)
	%BottomTextureButton3._on_main_button_pressed(self, selected_category)
	%BottomTextureButton4._on_main_button_pressed(self, selected_category)
	%BottomTextureButton5._on_main_button_pressed(self, selected_category)
	%BottomTextureButton6._on_main_button_pressed(self, selected_category)
	%BottomTextureButton7._on_main_button_pressed(self, selected_category)
	%BottomTextureButton8._on_main_button_pressed(self, selected_category)

func set_new_selected_item(new_item, category:String, index: int):
	# Deselect and remove the stats of the deselected item
	match category:
		"top":
			var clothing_item = top_clothing[index]
			%TopButton.texture_normal = clothing_items.get(clothing_item, clothing_items["empty"])
		"upper":
			var clothing_item = upper_clothing[index]
			%UpperButton.texture_normal = clothing_items.get(clothing_item, clothing_items["empty"])
		"bottom":
			var clothing_item = bottom_clothing[index]
			%BottomButton.texture_normal = clothing_items.get(clothing_item, clothing_items["empty"])
			
	selected_item_index = index	 

func _on_button_pressed() -> void:
	visible = false
