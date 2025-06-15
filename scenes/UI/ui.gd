extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Globals.game_time += delta
	$GameTime.text = str("%0.2f" % Globals.game_time, " seconds")
	var bullet_speed = 1/Globals.hand_cannon_firing_speed
	%AttackSpeedValue.text =  str("%0.2f" % bullet_speed, " Bullet/s")
	%AttackDamageValue.text =  str("%0.2f" % Globals.hand_cannon_bullet_damage, " Damage/Bullet")
	%PassThroughValue.text = str(Globals.pass_through, " Enemies")
