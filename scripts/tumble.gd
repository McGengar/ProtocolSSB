extends RigidBody2D

@onready var car: RigidBody2D = $"../Car"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_central_force(Vector2(-1,0)*10000*delta)
	$Area2D/Node2D.rotate(-3*delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body==car:
		car.knocked_back(Vector2(-1,0)*5000)
		apply_central_force(Vector2(1,0)*5000)
