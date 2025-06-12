extends Area2D
class_name Level1Chunk

var chunkCoordinates: Vector2 = Vector2(0, 0)

signal playerLocation(coord: Vector2, chunkSize: Vector2)
@onready var chunkSize: Vector2 = $ColorRect.size

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("PlayerState"):
		playerLocation.emit(chunkCoordinates, chunkSize)
		
