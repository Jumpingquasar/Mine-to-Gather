extends Area2D

var pickedVariation: Sprite2D
var isAttractedToPlayer: bool = false
@onready var player = get_node("/root/Level1/Player")
@export var speed = 100
@export var max_speed = 500
var isPassThrough = false

func _ready() -> void:	
	var BoulderVariationsArray: Array[Sprite2D] = [
		%Damage,
		%Health,
		%Speed
	]
	pickedVariation = BoulderVariationsArray.pick_random()
	isPassThrough = randi_range(0,10) == 2
	if isPassThrough:
		$Image/PassThrough.visible = true
	else:
		pickedVariation.visible = true
	

func _physics_process(delta: float) -> void:
	if isAttractedToPlayer:
		if speed != max_speed:
			speed += 100 * delta
		var direction = global_position.direction_to(player.global_position)
		position +=  direction * speed * delta
	else:
		speed = 0

func _on_pick_up_body_entered(body: Node2D) -> void:
	if body.has_node("PlayerState"):
		if isPassThrough:
			$Image/PassThrough.visible = false
			$Passthrough.play()
			Globals.pass_through += 1
		else:
			if pickedVariation == %Damage:
				%Damage.visible = false
				$Damage.play()
				Globals.hand_cannon_bullet_damage += 10
			elif pickedVariation == %Health:
				%Health.visible = false
				$Health.play()
				if Globals.player_health + 20 > 100:
					Globals.player_health = 100
				else:
					Globals.player_health += 20
			elif pickedVariation == %Speed:
				%Speed.visible = false
				$Speed.play()
				Globals.hand_cannon_firing_speed -= Globals.hand_cannon_firing_speed / 20

func _on_attract_body_entered(body: Node2D) -> void:
	if body.has_node("PlayerState"):
		isAttractedToPlayer = true


func _on_attract_body_exited(body: Node2D) -> void:
	if body.has_node("PlayerState"):
		isAttractedToPlayer = false
		

func _on_health_finished() -> void:
	queue_free()

func _on_speed_finished() -> void:
	queue_free()

func _on_damage_finished() -> void:
	queue_free()

func _on_passthrough_finished() -> void:
	queue_free()
