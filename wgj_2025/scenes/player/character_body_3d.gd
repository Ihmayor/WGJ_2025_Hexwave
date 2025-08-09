class_name Player extends CharacterBody3D

@export_group("Camera")
@export var movement_speed:float = 1000
@export_range (0.0, 1.0) var mouse_sensitivity:float = 0.25
@export var _gravity: float = -30.0
@export var acceleration: float = 20

var _camera_input_direction  = Vector2.ZERO
@onready var _camera_pivot : Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D

func _input(event: InputEvent) -> void:
	pass
	#if event.is_action_pressed("left_click"):
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#if event.is_action_pressed("ui_cancel"):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion = event is InputEventMouseMotion
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity


func _physics_process(delta: float) -> void:
	#Handle Camera
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, - PI/6.0, PI/3.0) # -30*  and -60* prevents overmovement of camera
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	_camera_input_direction = Vector2.ZERO
	
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
	velocity = velocity.move_toward(move_direction * movement_speed, delta * acceleration);
	move_and_slide()
	
	
