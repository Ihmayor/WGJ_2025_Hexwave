extends Control

@export var PlayerData : PlayerStats

func _ready():
	PlayerData.put_on_item.connect(_item_equipped)
	
func _item_equipped(category:String):
	#match category:
		#"top":
			#$TopFoley.play_one_shot()
		#"upper":
			#$TopFoley.play_one_shot()
		#"bottom":
			#$BottomFoley.play_one_shot()
	pass
