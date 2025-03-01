extends RigidBody2D

@export var speed =1000.0
var speed_multiplier = 1.0
var can_turn = true
var reverse = 1
var forced_turn =0
var turn = 0
var gas = 0
var alpha = 0
var can_rotate = 0
var angle = -78
var effect_transition = 0.0
var time = 100.0
var time_txt = ""

func _ready():
	$CanvasLayer/Sprite2D.visible=true

func _physics_process(delta):
	if time>0: time-=delta
	else: time=0.0
	time_txt = "%.02f" %time 	
	$CanvasLayer/RichTextLabel.text = "[center]"+time_txt+"[/center]"
	
	if time==0:
		$CanvasLayer/melon/elonani.play("heart going out")
	

	$CanvasLayer/indicator.modulate = Color(1,1,1,effect_transition*0.35)
	$CanvasLayer/indicator.scale = Vector2(effect_transition*16,effect_transition*16)
	if effect_transition>0:
		effect_transition-=1*delta
	$CanvasLayer/Sprite2D.modulate = Color(255,255,255,alpha)
	alpha-=0.5*delta
	turn = Input.get_axis("left","right")*delta*3*reverse
	if turn!=0 and can_turn:
		rotate(turn)
	if forced_turn!=0:
		rotate(forced_turn*delta*3.5)
	gas = Input.get_axis("forward","back")*delta
	if gas>0:
		gas*=0.5
	if time>0: apply_central_force(Vector2(0,gas).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*1000*delta)
	
	if Input.is_action_just_pressed("skill1") and $CanvasLayer/Skill1.value!=0 and time>0:
		$CanvasLayer/melon/elonani.play("sigmaboy")
		$CanvasLayer/melon/right.play("right")
		$CanvasLayer/Skill1/use.emitting = true
		use_skill($CanvasLayer/Skill1.value)
		$CanvasLayer/Skill1.value=0	
		await get_tree().create_timer(0.8).timeout
		$CanvasLayer/melon/elonani.play("jerkin")
		await get_tree().create_timer(2.2).timeout
		$CanvasLayer/Skill1/use.emitting = true
		$CanvasLayer/Skill1.value=randi_range(1,9)
	if Input.is_action_just_pressed("skill2") and $CanvasLayer/Skill2.value!=0 and time>0:
		$CanvasLayer/melon/elonani.play("sigmaboy")
		$CanvasLayer/melon/left.play("left")
		use_skill($CanvasLayer/Skill2.value)
		$CanvasLayer/Skill2/use.emitting = true
		$CanvasLayer/Skill2.value=0
		await get_tree().create_timer(0.8).timeout
		$CanvasLayer/melon/elonani.play("jerkin")
		await get_tree().create_timer(2.2).timeout
		$CanvasLayer/Skill2/use.emitting = true
		$CanvasLayer/Skill2.value=randi_range(1,9)
	
	if gas<0:
		$CPUParticles2D.emitting = true
		$CPUParticles2D2.emitting = true
	else:
		$CPUParticles2D.emitting = false
		$CPUParticles2D2.emitting = false

	$CanvasLayer/piwot1.rotation = deg_to_rad(angle	-90)
	$CanvasLayer/piwot2.rotation = deg_to_rad(angle	-90)
	if can_rotate != 0 :
		angle += 360*delta*can_rotate
		$CanvasLayer/CPUParticles2D.emitting = true
	if angle >= 220:
		can_rotate = -1
	if angle < -78 :
		can_rotate = 0
		$CanvasLayer/CPUParticles2D.emitting = false
	
func knocked_back(kbvect):
	sleeping = true
	apply_central_force(kbvect)
	await get_tree().create_timer(0.25).timeout
	sleeping = false
	
func use_skill(skill):
	await get_tree().create_timer(0.5).timeout
	effect_transition = 1
	$CanvasLayer/indicator.frame = skill
	match skill:
		1:
			speed_multiplier = 0.5
			apply_central_force(-Vector2(0,gas).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*500)
			await get_tree().create_timer(2).timeout
			speed_multiplier = 1
		2:
			linear_damp = -0.25
			await get_tree().create_timer(2).timeout
			linear_damp = 1
		3:
			apply_central_force(Vector2(0,gas).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*500)
		4:
			can_turn = false
			await get_tree().create_timer(2).timeout
			can_turn = true
		5:
			can_rotate = 1
			await get_tree().create_timer(2).timeout
			can_rotate = 1
		6:
			alpha=1.5
		7:
			reverse = -1
			await get_tree().create_timer(3).timeout
			reverse = 1
		8:
			forced_turn = -1
			await get_tree().create_timer(1).timeout
			forced_turn = 0
		9:
			forced_turn = 1
			await get_tree().create_timer(1).timeout
			forced_turn = 0
