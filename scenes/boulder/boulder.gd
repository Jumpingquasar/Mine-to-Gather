extends StaticBody2D



func _ready() -> void:
	
	var BoulderVariationsArray: Array = [
		$Boulder1,
		$Boulder2,
		$Boulder3	
	]
	
	var pickedVariation = BoulderVariationsArray.pick_random()
	pickedVariation.visible = true
