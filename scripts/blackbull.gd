extends RigidBody2D
var entered = false
var bison_speed = 0.01
# Called when the node enters the scene tree for the first time.
var sigmax = 1
var sigmay = 1
@onready var car: RigidBody2D = $"../Car"
var rng = RandomNumberGenerator.new()
func _ready() -> void:
	var my_random_number = rng.randi_range(0, 9)
	if my_random_number == 0:
		pass
	else:
		queue_free()
	visible = true
	sigmax = rng.randi_range(-1,1)
	sigmay = rng.randi_range(-1,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == car:
		for i in range(0,300):
			apply_central_force(Vector2(sigmax,sigmay)*200)
