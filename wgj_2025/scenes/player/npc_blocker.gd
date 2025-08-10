class_name NPCBlocker extends NPC

signal toggle_npc_menu(pass_check:bool)
@onready var npc_blocker_screen:NPCBlockerScreen = %NPCBlocker

func _ready() -> void:
	toggle_npc_menu.connect(npc_blocker_screen._on_npc_blocker_toggle_npc_menu)

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
