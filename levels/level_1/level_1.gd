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

func generate_chunks_around(coord: Vector2, chunkSize: Vector2) -> void:
	for val in chunkGenerationIndeces:
		var newChunkCoord = coord - val
		if newChunkCoord not in Globals.existingChunkLocations:
			var chunk = chunk_scene.instantiate() as Level1Chunk
			chunk.position = newChunkCoord * chunkSize
			chunk.chunkCoordinates = newChunkCoord
			chunk.playerLocation.connect(_on_level_1_chunk_player_location)
			Globals.existingChunkLocations.append(newChunkCoord)
			$Chunks.add_child(chunk)
		
func _on_level_1_chunk_player_location(coord: Vector2, chunkSize: Vector2) -> void:
	call_deferred("generate_chunks_around", coord, chunkSize)

func spawn_mob():
	var new_slime = preload("res://scenes/enemies/green_slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_slime.global_position = %PathFollow2D.global_position
	$Enemies.add_child(new_slime)



func _on_timer_timeout() -> void:
	spawn_mob()
