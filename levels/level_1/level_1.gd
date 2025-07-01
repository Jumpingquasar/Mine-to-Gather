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

func _ready() -> void:
	var chunk = chunk_scene.instantiate() as Level1Chunk
	chunk.position = Vector2.ZERO
	chunk.chunkCoordinates = Vector2.ZERO
	chunk.playerLocation.connect(_on_level_1_chunk_player_location)
	chunk.boulderBroken.connect(_on_boulder_boulder_broken)
	Globals.existingChunkLocations.append(Vector2.ZERO)
	$Chunks.add_child(chunk)

func generate_chunks_around(coord: Vector2, chunkSize: Vector2) -> void:
	for val in chunkGenerationIndeces:
		var newChunkCoord = coord - val
		if newChunkCoord not in Globals.existingChunkLocations:
			var chunk = chunk_scene.instantiate() as Level1Chunk
			chunk.position = newChunkCoord * chunkSize
			chunk.chunkCoordinates = newChunkCoord
			chunk.playerLocation.connect(_on_level_1_chunk_player_location)
			chunk.boulderBroken.connect(_on_boulder_boulder_broken)
			Globals.existingChunkLocations.append(newChunkCoord)
			$Chunks.add_child(chunk)
		
func _on_level_1_chunk_player_location(coord: Vector2, chunkSize: Vector2) -> void:
	call_deferred("generate_chunks_around", coord, chunkSize)

func spawn_mob():
	var new_slime = preload("res://scenes/enemies/green_slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_slime.global_position = %PathFollow2D.global_position
	$Enemies.add_child(new_slime)
	if Globals.game_time > 60:
		var new_red_slime = preload("res://scenes/enemies/red_slime/red_slime.tscn").instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_red_slime.global_position = %PathFollow2D.global_position
		$Enemies.add_child(new_red_slime)
		


func _on_timer_timeout() -> void:
	var interval = 10 / Globals.game_time
	call_deferred("spawn_mob")
	$Timer.start(interval)

func spawn_orb(boulderLocation: Vector2):
	var new_orb = preload("res://scenes/orb/orb.tscn").instantiate()
	new_orb.position = boulderLocation
	$Objects.add_child(new_orb)
	
func _on_boulder_boulder_broken(boulderLocation: Vector2) -> void:
	call_deferred("spawn_orb", boulderLocation)


func _on_player_player_death() -> void:
	%GameOver.visible = true
	var minutes = Globals.game_time / 60
	var seconds = int(Globals.game_time) % 60
	%TimeLasted.text = str(("%.0f" % minutes), " minutes and ", seconds, " seconds")
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	%GameOver.visible = false
	Globals.playerChunkLocation = Vector2(0,0)
	Globals.existingChunkLocations = [Vector2(0,0)]
	Globals.hand_cannon_bullet_damage = 5
	Globals.hand_cannon_firing_speed = 1
	Globals.game_time = 1
	Globals.player_health = 100
	Globals.pass_through = 0
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_background_music_finished() -> void:
	$BackgroundMusic.play(0)


func _on_resume_pressed() -> void:
		get_tree().paused = false
		$PauseMenu.visible = false
