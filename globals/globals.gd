extends Node

var playerMovementState: String = 'idle'

var playerChunkLocation: Vector2
var existingChunkLocations: Array[Vector2] = [Vector2(0,0)]
var hand_cannon_bullet_damage: float = 5
var hand_cannon_firing_speed: float = 1
var game_time: float = 1
var player_health: float = 100
var pass_through: int = 0
