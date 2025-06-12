extends Node2D

var chunk_scene = preload("res://scenes/chunk/level_1_chunk.tscn")
const chunkGenerationIndeces: Array[Vector2] = [
	Vector2(0, -1),
	Vector2(0, 1),
	Vector2(1, -1),
	Vector2(1, 0),
	Vector2(1, 1),
	Vector2(-1, -1),
	Vector2(-1, 0),
	Vector2(-1, 1),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_chunks_around(coord: Vector2, chunkSize: Vector2) -> void:
	for val in chunkGenerationIndeces:
		var chunk = chunk_scene.instantiate() as Level1Chunk
		chunk.position = (coord - val) * chunkSize
		chunk.chunkCoordinates = coord - val
		chunk.playerLocation.connect(_on_level_1_chunk_player_location)
		$Chunks.add_child(chunk)
		
func _on_level_1_chunk_player_location(coord: Vector2, chunkSize: Vector2) -> void:
	call_deferred("generate_chunks_around", coord, chunkSize)
