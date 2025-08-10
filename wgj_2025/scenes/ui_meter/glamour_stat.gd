class_name GlamourStatMeter extends StatMeter

func _ready():
	$MeterBar.max_value = PlayerData.MAX_GlAMOUR_STAT

func _physics_process(delta: float) -> void:
	$MeterBar.value = PlayerData.glamour_stat
