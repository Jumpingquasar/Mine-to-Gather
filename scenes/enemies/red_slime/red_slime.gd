extends CharacterBody2D

const LUNGE_SPEED: float = 400.0
const LUNGE_DURATION: float = 0.4
const LUNGE_INTERVAL: float = 2.0
var numerical_acceleration: int = 500
var numerical_deceleration: int = 1000
var max_speed: int = 100
@export var enemy_health: float = 300
@export var enemy_max_health: float = 300

@onready var player = get_node("/root/Level1/Player")

var lunge_velocity: Vector2 = Vector2.ZERO
var lunging: bool = false

func _ready():
	# Start the lunge loop
	$AnimationPlayer.play("red_slime_charging")
	_lunge_loop()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _lunge_loop() -> void:
	while true:
		await get_tree().create_timer(LUNGE_INTERVAL).timeout
		_start_lunge()
		await get_tree().create_timer(LUNGE_DURATION).timeout
		_stop_lunge()

func _start_lunge():
	if not player: return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * LUNGE_SPEED
	lunging = true

func _stop_lunge():
	velocity = velocity.move_toward(Vector2.ZERO, 350)
	lunging = false
	$AnimationPlayer.play("red_slime_charging")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
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
		$RedSlime.visible = false
		$Healthbar.visible = false
		$RedSlimeDeath.visible
		velocity = Vector2.ZERO
		$AnimationPlayer.play("death")
