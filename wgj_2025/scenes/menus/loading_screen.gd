extends Control

var next_scene = "res://scenes/main.tscn"

func _ready():
	ResourceLoader.load_threaded_request(next_scene)
	
func _process(delta):
	var progress = []
	ResourceLoader.load_threaded_get_status(next_scene, progress)
	%progress_bar.value = progress[0] * 100
	%progress_number.text = str(progress[0] * 100 )+ "%"
	
	if progress[0] == 1: 
		var packed_scene = ResourceLoader.load_threaded_get(next_scene)
		get_tree().change_scene_to_packed(packed_scene)
