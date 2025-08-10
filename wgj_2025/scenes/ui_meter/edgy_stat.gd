class_name EdgyStatMeter extends StatMeter

func _ready():
	$MeterBar.max_value = PlayerData.MAX_EDGY_STAT

func _physics_process(delta: float) -> void:
	$MeterBar.value = PlayerData.edgy_stat
