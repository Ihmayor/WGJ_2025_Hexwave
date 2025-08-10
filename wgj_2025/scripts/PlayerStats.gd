class_name PlayerStats extends Resource

@export var edgy_stat: int = 0 
@export var business_stat: int = 0
@export var glamour_stat: int = 0
 
@export var basic_player_stats:int = 0

@export var current_inventory:Array[ItemStats] 

@export var MAX_BUSINESS_STAT: int = 30
@export var MAX_GlAMOUR_STAT: int = 30
@export var MAX_EDGY_STAT: int = 30

func add_to_inventory(stats_to_add:ItemStats):
	current_inventory.append(stats_to_add)

func add_stats(stats_to_add:ItemStats):
	print("here")
	glamour_stat += stats_to_add.glamour_stat
	edgy_stat += stats_to_add.edgy_stat
	business_stat += stats_to_add.business_stat

func remove_stats(stats_to_remove:ItemStats):
	print("again")
	glamour_stat -= stats_to_remove.glamour_stat
	edgy_stat -= stats_to_remove.edgy_stat
	business_stat -= stats_to_remove.business_stat
