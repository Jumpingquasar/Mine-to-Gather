extends CharacterBody2D

@onready var player = get_node("/root/Level1/Player")
var numerical_acceleration: int = 500
var numerical_deceleration: int = 1000
var max_speed: int = 100
@export var enemy_health: float = 100
@export var enemy_max_health: float = 100

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = velocity.move_toward(direction * max_speed, numerical_acceleration * delta)
	move_and_collide(velocity * delta)
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "green_slime_death":
		queue_free()
	else:
		$AnimationPlayer.play(anim_name)

func enemy_take_damage(passThrough: int) -> void:
	$Hurt.play()
	enemy_health -= Globals.hand_cannon_bullet_damage / passThrough if passThrough else Globals.hand_cannon_bullet_damage
	$Healthbar.value = enemy_health * 100 / enemy_max_health
	if enemy_health <= 0:		
		var death_sound_copy = preload("res://scenes/enemies/death.tscn").instantiate()
		add_child(death_sound_copy)
		death_sound_copy.play()
		$GreenSlimeWalking.visible = false
		$GreenSlimeDeath.visible = true
		$Healthbar.visible = false
		velocity = Vector2.ZERO
		$AnimationPlayer.play("green_slime_death")
