class_name Player extends CharacterBody3D

@export var self_stats:PlayerStats
@export var reset_point: Node3D
@export_group("Camera")
@export var movement_speed:float = 2
@export var _gravity: float = -30.0
@export var acceleration: float = 4
@export var toggle_gravity: bool = true

var _camera_input_direction  = Vector2.ZERO
@onready var _camera: Camera3D = %MainCamera3D

var can_move:bool = true

func reset_to_last_point():
	position = reset_point.global_position
	can_move = true
	
func stop_moving():
	can_move = false
	
func _physics_process(delta: float) -> void:
	if (!can_move || _camera == null):
		return
		
	#Handle Player Movement
	var raw_input := Input.get_vector("move_left", "move_right","move_up","move_down",)
	var cam_dir: Vector3 = -_camera.global_transform.basis.z
	var move_direction : Vector3 = (transform.basis * Vector3(raw_input.x, 0, raw_input.y)).normalized()	
	#Store old velocity
	var y_velocity:= velocity.y
	velocity.y = 0.0
	if (toggle_gravity):
		velocity.y += _gravity
	
	if move_direction:
		var move_dir: Vector3 = Vector3.ZERO
		move_dir.x = move_direction.x
		move_dir.z = move_direction.z

		move_dir = move_dir.rotated(Vector3.UP, _camera.rotation.y).normalized()
		velocity.x = move_dir.x * movement_speed
		velocity.z = move_dir.z * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		velocity.z = move_toward(velocity.z, 0, movement_speed)

	move_and_slide()
	
	velocity.y = y_velocity + _gravity * delta
	var raw_velocity = velocity.move_toward(move_direction * movement_speed, delta * acceleration);
	velocity = Vector3(raw_velocity.x, raw_velocity.y, raw_velocity.z)
	if raw_input == Vector2.ZERO:
		velocity = Vector3.ZERO
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if (!can_move):
		return		
	if (event.is_action_pressed("open_inventory")):
		%DressupUI.visible = !%DressupUI.visible
