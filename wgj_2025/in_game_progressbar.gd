class_name in_game_progress_bar extends Sprite3D

var is_held_interact: bool = false


func increase_bar(value:int):
	%ProgressBar.value += value;
	
func reset_bar():
	%ProgressBar.value = 0

func _on_area_3d_body_entered(body: Node3D) -> void:
	%Label.visible = true
	%ProgressBar.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	%Label.visible = false
	%ProgressBar.visible = false
	
