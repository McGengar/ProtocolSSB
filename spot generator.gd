extends Node2D

var rng = RandomNumberGenerator.new()
var rozklad = "000000000000000"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0,14):
		var my_random_number = rng.randi_range(0, 1)
		rozklad[i] = str(my_random_number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
