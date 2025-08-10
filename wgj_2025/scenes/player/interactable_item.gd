class_name interactable_item extends RigidBody3D

@onready var pickup_screen = %PickUpUI ;
@export var Stats: ItemStats

func _ready() -> void:
	%Area3D.connect("body_entered", on_body_entered)
	%Area3D.connect("body_exited", on_body_exited)

func on_body_entered(body: Node3D) :
	if body is Player:
		pickup_screen._on_area_3d_body_entered(body, self)

func on_body_exited(body: Node3D) :
	if body is Player:
		pickup_screen._on_area_3d_body_exited(body, self)
