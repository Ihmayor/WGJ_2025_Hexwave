extends Control

@export var player_data:PlayerStats

func _physics_process(delta: float) -> void:
	print_values()

func print_values():
	$Label.text = "DEBUGGER: Glamour: "+ str(player_data.glamour_stat)+"\n"+"Edgy: "+ str(player_data.edgy_stat)+"\n"+"Business:" + str(player_data.business_stat)
