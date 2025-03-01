extends RigidBody2D

@export var speed =1000.0
var turn = 0
func _physics_process(delta):
	turn = Input.get_axis("left","right")*delta*3
	if turn!=0:
		rotate(turn)
	apply_central_force(Vector2(0,Input.get_axis("forward","back")*delta).rotated(rotation+deg_to_rad(90))*speed*1000*delta)

func knocked_back(kbvect):
	sleeping = true
	apply_central_force(kbvect)
	await get_tree().create_timer(0.25).timeout
	sleeping = false
