class_name NPCBlocker extends NPC

signal toggle_npc_menu(pass_check:bool)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		var is_player_blocked =check_player_stats()
		toggle_npc_menu.emit(is_player_blocked)
		if (!is_player_blocked):
			await get_tree().create_timer(0.7).timeout
			queue_free()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		toggle_npc_menu.emit(check_player_stats())
