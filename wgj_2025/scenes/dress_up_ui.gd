class_name DressUpUI extends Control

@export var PlayerData: PlayerStats

@onready var top_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer5/MarginContainer/TopGrid
@onready var upper_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer6/MarginContainer/UpperGrid
@onready var bottom_grid = $PanelContainer4/MarginContainer/GridContainer/PanelContainer7/MarginContainer/BottomGrid

signal disable_selection_press

var selected_category: String = ""
var selected_item_index: int = -1 
var selected_button: TextureButton = null

var current_inventory_amount: int

var top_button_currently_equipped: ItemStats
var upper_button_currently_equipped: ItemStats
var bottom_button_currently_equipped: ItemStats

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
func _physics_process(delta: float) -> void:
	#Check if Player Data has new items
	if current_inventory_amount < PlayerData.current_inventory.size():
		current_inventory_amount +=1
		var found_item:ItemStats = PlayerData.current_inventory.back()
		player_found_item(found_item.resource_path, found_item.item_location)

func player_found_item(item_id: String, category: String):
	match category:
		"top":
			add_to_inventory_ui("top")
		"upper":
			add_to_inventory_ui("upper")
		"bottom":
			add_to_inventory_ui("bottom")

func add_to_inventory_ui(category: String):
	var items: Array[ItemStats]
	var container: GridContainer
	match category:
		"top":
			items = PlayerData.current_inventory.filter(func(n): return n.item_location == "top")
			container = top_grid
		"upper":
			items = PlayerData.current_inventory.filter(func(n): return n.item_location == "upper")
			container =  upper_grid
		"bottom":
			items = PlayerData.current_inventory.filter(func(n): return n.item_location == "bottom")
			container = bottom_grid

	# Update buttons for each category
	var buttons = container.get_children()
	for i in range(len(items)): #TODO: check that buttons are not out of range (should not happen though)
		if buttons[i] is TextureButton and buttons[i].disabled:
			buttons[i].texture_normal = ResourceLoader.load(items[i].icon_for_item)
			#Tell the buttons what stat they're connected with
			if buttons[i] is EquipButton:
				(buttons[i] as EquipButton).set_related_item(items[i], i)
				disable_selection_press.connect((buttons[i] as EquipButton).deselect)
			buttons[i].disabled = false
			

func _on_top_button_pressed() -> void:
	if (top_grid.visible):
		show_labels()
		return

	selected_category = "top"
	selected_item_index = -1  
	top_grid.visible = true
	upper_grid.visible = false
	bottom_grid.visible = false

	hide_labels()
	
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
	if (upper_grid.visible):
		show_labels()
		return
	selected_category = "upper"
	selected_item_index = -1
	upper_grid.visible = true
	top_grid.visible = false
	bottom_grid.visible = false
	hide_labels()
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
	if (bottom_grid.visible):
		show_labels()
		return
	selected_category = "bottom"
	selected_item_index = -1

	upper_grid.visible = false
	top_grid.visible = false
	bottom_grid.visible = true

	hide_labels()
	#Hook up top buttons with the buttons in their column 
	%BottomTextureButton._on_main_button_pressed(self, selected_category)
	%BottomTextureButton2._on_main_button_pressed(self, selected_category)
	%BottomTextureButton3._on_main_button_pressed(self, selected_category)
	%BottomTextureButton4._on_main_button_pressed(self, selected_category)
	%BottomTextureButton5._on_main_button_pressed(self, selected_category)
	%BottomTextureButton6._on_main_button_pressed(self, selected_category)
	%BottomTextureButton7._on_main_button_pressed(self, selected_category)
	%BottomTextureButton8._on_main_button_pressed(self, selected_category)

func set_new_selected_item(new_item:ItemStats, category:String, index: int):
	#Assign Main Button with newly selected Item
	var main_button
	match category:
		"top":
			if (top_button_currently_equipped != null):
				PlayerData.remove_stats(top_button_currently_equipped)
			else:
				PlayerData.put_on_item.emit("top")
			top_button_currently_equipped = new_item
			main_button = %TopButton
		"upper":
			if (upper_button_currently_equipped != null):
				PlayerData.remove_stats(upper_button_currently_equipped)
			else:
				PlayerData.put_on_item.emit("upper")
			upper_button_currently_equipped = new_item
			main_button = %UpperButton
		"bottom":
			if (bottom_button_currently_equipped != null):
				PlayerData.remove_stats(bottom_button_currently_equipped)
			else:
				PlayerData.put_on_item.emit("bottom")
			bottom_button_currently_equipped = new_item
			main_button = %BottomButton
	PlayerData.add_stats(new_item)
	main_button.texture_normal = ResourceLoader.load(new_item.icon_for_item)
	selected_item_index = index	 
	
	show_labels()

func hide_labels():
	%BottomGridLabel.visible = false
	%UpperGridLabel.visible = false
	%TopGridLabel.visible = false

func show_labels():
	top_grid.visible = false
	upper_grid.visible = false
	bottom_grid.visible = false
	
	%BottomGridLabel.visible = true
	%UpperGridLabel.visible = true
	%TopGridLabel.visible = true

func _on_button_pressed() -> void:
	visible = false
