extends Node3D
@onready var theme = %MainTheme
@onready var win_screen =%Win

func _on_area_3d_body_entered(body: Node3D) -> void:
	if (body is not Player):
		return
	theme.stop()
	$AreaAmbience.play()
	$AreaMusic.play()
	await get_tree().create_timer(2).timeout
	win_screen.on_win()
