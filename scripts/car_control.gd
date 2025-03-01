extends RigidBody2D

@export var speed =1000.0
var speed_multiplier = 1.0
var can_turn = true
var reverse = 1
var turn = 0
var gas = 0
func _physics_process(delta):
	turn = Input.get_axis("left","right")*delta*3*reverse
	if turn!=0 and can_turn:
		rotate(turn)
	gas = Input.get_axis("forward","back")*delta
	apply_central_force(Vector2(0,gas).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*1000*delta)
	
	if Input.is_action_just_pressed("skill1") and $CanvasLayer/Skill1.value!=0:
		use_skill($CanvasLayer/Skill1.value)
		$CanvasLayer/Skill1.value=0
		await get_tree().create_timer(3.0).timeout
		$CanvasLayer/Skill1.value=randi_range(1,9)
	if Input.is_action_just_pressed("skill2") and $CanvasLayer/Skill2.value!=0:
		use_skill($CanvasLayer/Skill2.value)
		$CanvasLayer/Skill2.value=0
		await get_tree().create_timer(3.0).timeout
		$CanvasLayer/Skill2.value=randi_range(1,9)
	
	if gas<0:
		$CPUParticles2D.emitting = true
		$CPUParticles2D2.emitting = true
	else:
		$CPUParticles2D.emitting = false
		$CPUParticles2D2.emitting = false
func knocked_back(kbvect):
	sleeping = true
	apply_central_force(kbvect)
	await get_tree().create_timer(0.25).timeout
	sleeping = false
	
func use_skill(skill):
	match skill:
		1:
			speed_multiplier = 0.5
			apply_central_force(-Vector2(0,gas).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*1000)
			await get_tree().create_timer(2).timeout
			speed_multiplier = 1
		2:
			linear_damp = -0.5
			await get_tree().create_timer(2).timeout
			linear_damp = 1
		3:
			apply_central_force(Vector2(0,-1).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*1000)
		4:
			can_turn = false
			await get_tree().create_timer(2).timeout
			can_turn = true
		5:
			pass
		6:
			pass
		7:
			reverse = -1
			await get_tree().create_timer(2).timeout
			reverse = 1
		8:
			pass
		9:
			pass
