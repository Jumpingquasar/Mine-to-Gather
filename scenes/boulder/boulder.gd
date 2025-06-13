extends StaticBody2D

var pickedVariation

func _ready() -> void:	
	var BoulderVariationsArray: Array = [
		$Boulder1,
		$Boulder2,
		$Boulder3	
	]	
	pickedVariation = BoulderVariationsArray.pick_random()
	pickedVariation.visible = true
	$Timer.start(randi_range(1,10))

func on_boulder_break() -> void:
	pass



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play(anim_name)


func _on_timer_timeout() -> void:
	if (pickedVariation == $Boulder1):
		$AnimationPlayer.play("Boulder1_sparkle")
	elif (pickedVariation == $Boulder2):
		$AnimationPlayer.play("Boulder2_sparkle")
		
