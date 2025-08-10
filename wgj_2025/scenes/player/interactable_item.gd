class_name interactable_item extends RigidBody3D

@onready var PickupScreen = %PickUpUI ;
@export var Stats: ItemStats

func _ready() -> void:
	var item_model_loaded = ResourceLoader.load(Stats.model_path)
	add_child(item_model_loaded)
	%Area3D.connect("body_entered", on_body_entered)
	%Area3D.connect("body_exited", on_body_exited)

func on_body_entered(body: Node3D) :
	if body is Player:
		PickupScreen._on_area_3d_body_entered(body, self)

func on_body_exited(body: Node3D) :
	if body is Player:
		PickupScreen._on_area_3d_body_exited(body, self)
