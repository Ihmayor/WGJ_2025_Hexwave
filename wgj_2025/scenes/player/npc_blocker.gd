class_name NPCBlocker extends Node

@export var player_stats:PlayerStats
@export var glam_check_amount:int
@export var business_check_amount:int
@export var edgy_check_amount:int

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

func check_player_stats() -> bool:
	if (player_stats == null):
		return false
	var diff_glam = glam_check_amount - player_stats.glamour_stat 
	var diff_business = business_check_amount - player_stats.business_stat
	var diff_edgy 	= edgy_check_amount - player_stats.business_stat

	if (diff_glam > 0 || diff_business > 0 || diff_edgy > 0):
		return true
	else:
		return false
