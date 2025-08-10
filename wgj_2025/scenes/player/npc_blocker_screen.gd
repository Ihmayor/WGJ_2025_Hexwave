extends Control

var player_blocked_message:String = "Hey! You can't enter here looking like that!"
var player_unblocked_message:String = "Oh nice! Lookin' good!"

func _on_npc_blocker_toggle_npc_menu(is_player_blocked:bool):
	visible = !visible
	if (is_player_blocked):
		$Panel/Label.text = player_blocked_message
	else: 
		$Panel/Label.text = player_unblocked_message	
