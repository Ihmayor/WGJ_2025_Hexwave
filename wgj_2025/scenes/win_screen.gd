class_name WinScreen extends Control

func on_win():
	visible = true
	$ColorRect/AnimationPlayer.play("fade_out")
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://EndScene.tscn") # Replace with function body.
