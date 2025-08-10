class_name PanicScreen extends Control
@export var small_talk_lines: Array[String]

func _on_npc_reseter_panic(player: Node3D) -> void:
	visible = true
	$Button.visible = false
	%TextureProgressBar.value = 50
	%PanicControl.visible = true
	
func _physics_process(delta: float) -> void:
	if (!visible):
		return
		
	if %TextureProgressBar.value <= 0 && !$Button.visible: 
		%TextureProgressBar.value = 0
		%NPCReseter.show_dialogue("You're...an alien!!!")
		await get_tree().create_timer(0.7).timeout
		%Player.reset_to_last_point()
		%TextureProgressBar.value = 50
		%PanicControl.visible = false
		$Button.visible = false
		visible = false
		
	elif %TextureProgressBar.value >= 100:
		%TextureProgressBar.value = 50
		%PanicControl.visible = false
		$Button.visible = true
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.echo == false:
		%TextureProgressBar.value += 11
	

func _on_panic_decrease_timer_timeout() -> void:
	%TextureProgressBar.value -= 8
	if %TextureProgressBar.value < 0:
		%TextureProgressBar.value = 0

func _on_button_pressed() -> void:
	%NPCReseter.show_dialogue(small_talk_lines.pick_random())
	$Button.visible = false
	%PanicControl.visible = true
	%Player.can_move = true
	visible = false
