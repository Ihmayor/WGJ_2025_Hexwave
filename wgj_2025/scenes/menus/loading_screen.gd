extends Control

var next_scene = ""

func _ready():
	ResourceLoader.load_threaded_request(next_scene)
	
func _progress(delta):
	var progress = []
	ResourceLoader.load_threaded_get_status(next_scene, progress)
	
