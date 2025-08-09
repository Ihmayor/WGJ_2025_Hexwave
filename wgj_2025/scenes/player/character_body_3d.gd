class_name Player extends CharacterBody3D

@export var movement_speed:float = 10


func _physics_process(delta: float) -> void:
	var raw_input := Input.get_vector("move_left", "move_right","move_down","move_up")
	var forward := global_basis.z 
	var right : = global_basis.x
	print(right)
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()	

	velocity = velocity.move_toward(move_direction * movement_speed, delta);
	move_and_slide()
	
	
