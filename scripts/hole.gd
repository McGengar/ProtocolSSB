extends StaticBody2D
var in_hole = false
var was_slept = false
@onready var car: RigidBody2D = $"../Car"

func _physics_process(delta: float) -> void:
	if in_hole:
		car.speed_multiplier = 0.3
		await get_tree().create_timer(0.1).timeout
		if in_hole and not was_slept:
			car.sleeping = true
			was_slept = true
func _on_area_2d_body_entered(body: RigidBody2D) -> void:
	in_hole = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	in_hole = false
	car.speed_multiplier = 1
	car.sleeping = false
	was_slept = false
