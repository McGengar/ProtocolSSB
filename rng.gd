extends Node2D

var rng = RandomNumberGenerator.new()
func _ready() -> void:
	for i in range(0,14):
		var my_random_number = rng.randi_range(0, 2)
		print(my_random_number)
