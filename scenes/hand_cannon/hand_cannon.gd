extends Area2D

func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
		
	if enemies_in_range.size():
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
		if $Timer.is_stopped():
			$Timer.start(Globals.hand_cannon_firing_speed)
			shoot()

func shoot():
	const BULLET = preload("res://scenes/hand_cannon/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	$AnimationPlayer.play("shoot")	
