class_name NPCReseter extends NPC

signal open_npc_menu(message:String)
signal close_npc_menu()
signal panic(player:Node3D)

@export var accuse_message: String = "Hey! Wh-what are you..."
@export var succeed_message: String = "Oh! never mind..."
@export var fail_message: String = "WAIT! You're an ALIEN!!!"


func _ready() -> void:
	if $Area3D.body_entered.get_connections().size() == 0:
		$Area3D.body_entered.connect(_on_area_3d_body_entered)
		
	if $Area3D.body_exited.get_connections().size() == 0:
		$Area3D.body_exited.connect(_on_area_3d_body_exited)
	

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		var is_player_sus = check_player_stats()
		if is_player_sus:
			open_npc_menu.emit(accuse_message)
			panic.emit(body)
			(body as Player).stop_moving()
			

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		close_npc_menu.emit()
