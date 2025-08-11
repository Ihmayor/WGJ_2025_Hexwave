class_name RemoveRoof extends Area3D

@export var triggered_camera: PhantomCamera3D
@export var triggered_fmod: FmodEventEmitter3D
@export var triggered_fmodMusic: FmodEventEmitter3D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body:Node3D):
	if body is not Player:
		return
	triggered_fmod.play()
	triggered_fmodMusic.play()
	triggered_camera.priority = 30
	var all_roofs = get_tree().get_nodes_in_group("roof");
	print(all_roofs.size())
	for roof in all_roofs:
		roof.visible = false;

func _on_body_exited(body:Node3D):
	if body is not Player:
		return
	triggered_camera.priority = 4
	var all_roofs = get_tree().get_nodes_in_group("roof");
	print(all_roofs.size())
	for roof in all_roofs:
		roof.visible = true;
	triggered_fmod.stop()
	triggered_fmodMusic.stop()
	
