extends Node2D

var rng = RandomNumberGenerator.new()
@onready var bizon = preload("res://scenes/rigid_bison.tscn")

func _ready() -> void:
	var my_random_number = rng.randi_range(0, 1)
	visible = my_random_number
	if visible == true:
		var instacja = bizon.instantiate()
		instacja.rotation = rotation
		add_child(instacja)
