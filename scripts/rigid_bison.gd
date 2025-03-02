extends RigidBody2D
var entered = false
var bison_speed = 0.01
# Called when the node enters the scene tree for the first time.
var sigmax = 1
var sigmay = 1
@onready var car: RigidBody2D = $"../Car"
var rng = RandomNumberGenerator.new()
func _ready() -> void:
	var my_random_number = rng.randi_range(0, 1)
	if my_random_number == 0:
		queue_free()
	if rotation > deg_to_rad(100):
		sigmax = 0
		sigmay = -1
	elif rotation > 0:
		sigmax = -1
		sigmay = 0
	elif rotation == 0:
		sigmax= 0
		sigmay = 1
	elif rotation < 0:
		sigmax = 1
		sigmay = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == car:
		for i in range(0,300):
			apply_central_force(Vector2(sigmax,sigmay)*100)
