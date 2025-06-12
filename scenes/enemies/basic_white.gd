extends CharacterBody2D

@onready var player = get_node("/root/ParentLevel/Player")
var numerical_acceleration: int = 500
var numerical_deceleration: int = 1000
var max_speed: int = 100

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = velocity.move_toward(direction * max_speed, numerical_acceleration * delta)
	move_and_slide()



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play(anim_name)
