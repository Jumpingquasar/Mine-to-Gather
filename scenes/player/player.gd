extends CharacterBody2D

var numerical_acceleration: int = 500
var numerical_deceleration: int = 1000
var max_speed: int = 300
const DAMAGE_RATE = 5.0

signal player_death

func _ready():
	$AnimationPlayer.play("idle")

func _process(delta: float):
	
	var direction = Input.get_vector("left","right","up", "down")
	
	if direction[0] < 0:
		$PlayerState.scale = Vector2(-1, 1)
	elif direction[0] > 0:
		$PlayerState.scale = Vector2(1, 1)
	
	if !$MiningTimer.is_stopped():
		velocity = velocity.move_toward(Vector2.ZERO, numerical_deceleration * delta )
	elif direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * max_speed, numerical_acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, numerical_deceleration * delta)
	
	if Input.is_action_just_pressed("mine"):
		$MiningTimer.start(0.4)
		Globals.playerMovementState = MovementState.mining
		_on_player_movement_state_changed(MovementState.mining)
	elif $MiningTimer.is_stopped():
		if velocity:
			Globals.playerMovementState = MovementState.walking
			_on_player_movement_state_changed(MovementState.walking)
		else:
			Globals.playerMovementState = MovementState.idle
			_on_player_movement_state_changed(MovementState.idle)
	move_and_slide()
	var overlapping_mobs = $HurtBox.get_overlapping_bodies()
	var overlapping_enemies = overlapping_mobs.filter(func(element): return element.has_method("enemy_take_damage"))
	if overlapping_enemies.size():
		$Hurt.play()
		Globals.player_health -= DAMAGE_RATE * overlapping_enemies.size() * delta
		$Healthbar.value = Globals.player_health
		if Globals.player_health <= 0:
			$Death.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play(anim_name)

func _on_player_movement_state_changed(state: String): 
	$PlayerState/MinerIdle.visible =  state == MovementState.idle
	$PlayerState/MinerWalking.visible =  state == MovementState.walking
	$PlayerState/MinerMining.visible = state == MovementState.mining
	$AnimationPlayer.play(state)
	

func _on_minable_area_body_entered(body: Node2D) -> void:
	if body.has_method("on_boulder_break"):
		body.isMinable = true

func _on_minable_area_body_exited(body: Node2D) -> void:
	if body.has_method("on_boulder_break"):
		body.isMinable = false
		
func _on_death_finished() -> void:
	player_death.emit()
