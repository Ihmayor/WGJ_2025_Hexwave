extends Control

func show_dialogue(player_message:String):
	visible = true
	$Panel/Label.text = player_message
	
func hide_dialogue():
	visible = false
