class_name NPC extends Node

@export var player_stats:PlayerStats
@export var glam_check_amount:int
@export var business_check_amount:int
@export var edgy_check_amount:int

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
