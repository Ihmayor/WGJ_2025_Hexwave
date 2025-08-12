class_name NPCBlockerScreen extends Control

@export var player_blocked_message:String = "Hey! You can't enter here looking like that!"
@export var player_unblocked_message:String = "Oh nice! Lookin' good!"

func _on_npc_blocker_toggle_npc_menu(is_player_blocked:bool, blocked_message:String, unblocked_message:String):
	visible = !visible
	if (is_player_blocked):
		if blocked_message != "":
			$Panel/Label.text = blocked_message
		else:		
			$Panel/Label.text = player_blocked_message
	else: 
		if unblocked_message != "":
			$Panel/Label.text = unblocked_message
		else:		
			$Panel/Label.text = player_unblocked_message
	
