extends Control

var is_held_interact:bool

var item_in_view: interactable_item
@export var PlayerData:PlayerStats
@export var SFX:FmodEventEmitter3D

@onready var progressbar:ProgressBar = %ProgressBar

func _physics_process(delta: float) -> void:
	if (is_held_interact && visible):
		if progressbar.value == progressbar.max_value:
			if (item_in_view != null):
				SFX.play_one_shot()
				PlayerData.add_to_inventory(item_in_view.Stats)
				item_in_view.queue_free()
		progressbar.value += 10
		
func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("interact")):
		is_held_interact = true
	elif (event.is_action_released("interact")):
		is_held_interact = false
		
func _on_area_3d_body_exited(body: Node3D, itemCaller: Node) -> void:
	if body is Player:
		visible = false
		item_in_view = null
		progressbar.value = 0

func _on_area_3d_body_entered(body: Node3D, itemCaller: Node) -> void:
	if body is Player:
		item_in_view = itemCaller
		visible = true
