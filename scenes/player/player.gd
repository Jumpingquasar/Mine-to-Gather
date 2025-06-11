extends CharacterBody2D

@export var max_speed: int = 200
var speed: int = 0
var acceleration: float = 100

func _ready():
	$AnimationPlayer.play("idle")

func _process(_delta: float):
	var direction = Input.get_vector("left","right","up", "down")
	
	if direction[0] < 0:
		$PlayerState.scale = Vector2(-1, 1)
	elif direction[0] > 0:
		$PlayerState.scale = Vector2(1, 1)
	
	velocity = direction * (speed + acceleration)
	
	if velocity:
		$PlayerState/MinerIdle.visible = false
		$PlayerState/MinerWalking.visible = true
		$AnimationPlayer.play("walking")
	else:
		$PlayerState/MinerIdle.visible = true
		$PlayerState/MinerWalking.visible = false
		$AnimationPlayer.play("idle")

	move_and_slide()



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play(anim_name)
