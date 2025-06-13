extends Area2D
class_name Level1Chunk

var chunkCoordinates: Vector2 = Vector2(0, 0)
var boulder_scene = preload("res://scenes/boulder/boulder.tscn")

signal playerLocation(coord: Vector2, chunkSize: Vector2)
@onready var chunkSize: Vector2 = $ColorRect.size
@onready var player = get_node("/root/ParentLevel/Player")

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("PlayerState"):
		playerLocation.emit(chunkCoordinates, chunkSize)
		
func _process(_delta: float) -> void:
	if global_position.distance_to(player.global_position) > 4000:
		Globals.existingChunkLocations.erase(chunkCoordinates)
		queue_free()

func _ready() -> void:
	var boulderAmount = randi_range(3, 20)
	for i in range(boulderAmount):
		var boulderX = randi_range(-500, 500)
		var boulderY = randi_range(-300, 300)
		var boulder = boulder_scene.instantiate()
		boulder.position = Vector2(boulderX, boulderY)
		$Objects.add_child(boulder)
