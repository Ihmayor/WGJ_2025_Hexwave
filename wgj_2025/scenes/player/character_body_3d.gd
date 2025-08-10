class_name Player extends CharacterBody3D

@export var self_stats:PlayerStats
@export var reset_point: Node3D
@export_group("Camera")
@export var movement_speed:float = 1000
@export_range (0.0, 1.0) var mouse_sensitivity:float = 0.25
@export var _gravity: float = -30.0
@export var acceleration: float = 4

var _camera_input_direction  = Vector2.ZERO
@export var _camera: Camera3D

var can_move:bool = true

func reset_to_last_point():
	position = reset_point.global_position
	can_move = true
	
func stop_moving():
	can_move = false

func _physics_process(delta: float) -> void:
	if (!can_move):
		return
		
	#Handle Player Movement
	var raw_input := Input.get_vector("move_left", "move_right","move_up","move_down",)
	var forward := _camera.global_basis.z 
	var right : = _camera.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction = move_direction.normalized()	
	#Store old velocity
	var y_velocity:= velocity.y
	velocity.y = 0.0
	velocity.y = y_velocity + _gravity * delta
	velocity = velocity.move_toward(move_direction * movement_speed, clamp(delta * acceleration, 0, 2));
	if raw_input == Vector2.ZERO:
		velocity = Vector3.ZERO
	move_and_slide()
	

func add_stats(stats_to_add:ItemStats):
	print(stats_to_add.resource_name)
	self_stats.current_inventory.append(stats_to_add)
	print("add stats")
	self_stats.glamour_stat += stats_to_add.glamour_stat
	self_stats.edgy_stat += stats_to_add.edgy_stat
	self_stats.business_stat += stats_to_add.business_stat
	print(self_stats.glamour_stat)
	
