extends Area2D
@onready var car: RigidBody2D = $"../Car"

func _on_body_entered(body):
	if body==car:
		car.wins()
