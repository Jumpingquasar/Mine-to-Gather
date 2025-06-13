extends Area2D

@export var SPEED = 1000
@export var RANGE = 2000
var travelled_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position +=  direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
		queue_free()
		if body.has_method("enemy_take_damage"):
			body.enemy_take_damage()
	
