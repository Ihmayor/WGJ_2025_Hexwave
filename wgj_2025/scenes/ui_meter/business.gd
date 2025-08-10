class_name BusinessStatMeter extends StatMeter

func _ready():
	$MeterBar.max_value = PlayerData.MAX_BUSINESS_STAT

func _physics_process(delta: float) -> void:
	$MeterBar.value = PlayerData.business_stat
