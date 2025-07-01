extends CanvasLayer


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		
		if (!get_tree().paused):
			get_tree().paused = true
			visible = true
		else:
			get_tree().paused = false
			visible = false
