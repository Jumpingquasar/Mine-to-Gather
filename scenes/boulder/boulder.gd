extends StaticBody2D

var pickedVariation: Sprite2D
var isMinable: bool = false
signal boulderBroken(boulderLocation)

func _ready() -> void:	
	var BoulderVariationsArray: Array[Sprite2D] = [
		$Boulder1,
		$Boulder2,
		$Boulder3	
	]	
	pickedVariation = BoulderVariationsArray.pick_random()
	pickedVariation.visible = true
	$Timer.start(randi_range(1,10))

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("mine") and isMinable:
		on_boulder_break()
	if isMinable:
		pickedVariation.modulate = Color(0.36, 0.49, 0.30, 1)
	else:
		pickedVariation.modulate = Color(1, 1, 1, 1)
		
	
func on_boulder_break() -> void:
	$BoulderBreak.play()
	pickedVariation.visible = false
	$CollisionShape2D.disabled = true
	$ShadowBoulder.visible = false
	$BoulderBreaking.visible = true
	boulderBroken.emit(global_position)
	$AnimationPlayer.play("break")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "break":
		$BoulderBreaking.visible = false		
		queue_free()
	$AnimationPlayer.play(anim_name)

func _on_timer_timeout() -> void:
	if (pickedVariation == $Boulder1):
		$AnimationPlayer.play("Boulder1_sparkle")
	elif (pickedVariation == $Boulder2):
		$AnimationPlayer.play("Boulder2_sparkle")
		
