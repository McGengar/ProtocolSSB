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
var start_timer = 4.0;
var time = 100.0
var time_txt = ""
var win = false
var loose = false
var last_skill= 0

func _ready():
	$Sound_effects/Gameloop.play()
	$CanvasLayer/Sprite2D.visible=true

func _physics_process(delta):
	if start_timer>0:
		start_timer-=delta
	else:
		start_timer=-0.009	
	$CanvasLayer/START.frame = 3-floor(start_timer)
	$CanvasLayer/START.modulate = Color(255,255,255,start_timer-floor(start_timer))
	if win==false and start_timer<=1:
		if time>0: time-=delta
		else: time=0.0
	time_txt = "%.02f" %time 	
	$CanvasLayer/RichTextLabel.text = "[center]"+time_txt+"[/center]"
	
	if time==0 and loose==false:
		loose=true
		var sounds = $Sounds.get_children()
		for sound in sounds:
			sound.stop()
		$Sound_effects/Lost.play()
		await get_tree().create_timer(1).timeout
		$CanvasLayer/melon/elonani.play("heart going out")
		$Sounds/Win1.play()
		await get_tree().create_timer(2).timeout
		$Sounds/Designerwins2.play()
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/selection_screen.tscn")
		
	

	$CanvasLayer/indicator.modulate = Color(1,1,1,effect_transition*0.35)
	$CanvasLayer/indicator.scale = Vector2(effect_transition*16,effect_transition*16)
	if effect_transition>0:
		effect_transition-=1*delta
	$CanvasLayer/Sprite2D.modulate = Color(255,255,255,alpha)
	alpha-=0.5*delta
	turn = Input.get_axis("left","right")*delta*3*reverse
	if turn!=0 and can_turn and time>0 and time<100 and win==false:
		rotate(turn)
	if forced_turn!=0:
		rotate(forced_turn*delta*3.5)
	gas = Input.get_axis("forward","back")*delta
	if gas>0:
		gas*=0.5
	if time>0 and time<100 and win==false: apply_central_force(Vector2(0,gas).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*1000*delta)
	
	if Input.is_action_just_pressed("skill1") and $CanvasLayer/Skill1.value!=0 and time>0 and time<100 and win==false:
		$CanvasLayer/melon/elonani.play("sigmaboy")
		$CanvasLayer/melon/right.play("right")
		$CanvasLayer/Skill1/use.emitting = true
		last_skill = $CanvasLayer/Skill1.value
		use_skill($CanvasLayer/Skill1.value)
		$CanvasLayer/Skill1.value=0	
		await get_tree().create_timer(0.8).timeout
		if time>0 and time<100 and win==false:$CanvasLayer/melon/elonani.play("jerkin")
		await get_tree().create_timer(5.2).timeout
		$CanvasLayer/Skill1/use.emitting = true
		$CanvasLayer/Skill1.value=randi_range(1,9)
		while last_skill == $CanvasLayer/Skill1.value:
			$CanvasLayer/Skill1.value=randi_range(1,9)
	if Input.is_action_just_pressed("skill2") and $CanvasLayer/Skill2.value!=0 and time>0 and time<100 and win==false:
		$CanvasLayer/melon/elonani.play("sigmaboy")
		$CanvasLayer/melon/left.play("left")
		last_skill = $CanvasLayer/Skill2.value
		use_skill($CanvasLayer/Skill2.value)
		$CanvasLayer/Skill2/use.emitting = true
		$CanvasLayer/Skill2.value=0
		await get_tree().create_timer(0.8).timeout
		if time>0 and time <100 and win==false:$CanvasLayer/melon/elonani.play("jerkin")
		await get_tree().create_timer(5.2).timeout
		$CanvasLayer/Skill2/use.emitting = true
		$CanvasLayer/Skill2.value=randi_range(1,9)
		while last_skill == $CanvasLayer/Skill2.value:
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
	$Sound_effects/Hit.play()
	await get_tree().create_timer(0.25).timeout
	sleeping = false
	
func use_skill(skill):
	var rng = 0
	var is_sound_playing = false
	var sounds = $Sounds.get_children()
	for sound in sounds:
		if sound.playing==true:
			is_sound_playing=true
	if is_sound_playing==false:
		match skill:
			1:
				rng = randi_range(0,1)
				if rng==0:
					$"Sounds/Slow 1".play()
				else:
					$"Sounds/Slow 2".play()
			2:
				rng = randi_range(0,1)
				if rng==0:
					$"Sounds/Banan 1".play()
				else:
					$"Sounds/Banan 2".play()
			3:
				$Sounds/Hop.play()
			4:
				rng = randi_range(0,2)
				if rng==0:
					$"Sounds/Block 1".play()
				elif rng== 1:
					$"Sounds/Block 2".play()
				else:
					$"Sounds/Block 3".play()
			5:
				rng = randi_range(0,1)
				if rng==0:
					$"Sounds/Wycieraczki 1".play()
				else:
					$"Sounds/Wycieraczki 2".play()
			6:
				rng = randi_range(0,2)
				if rng==0:
					$"Sounds/Flashbang 1".play()
				elif rng== 1:
					$"Sounds/Flashbang 2".play()
				else:
					$"Sounds/Flashbang 3".play()
			7:
				rng = randi_range(0,2)
				if rng==0:
					$"Sounds/Reverse 1".play()
				elif rng== 1:
					$"Sounds/Reverse 2".play()
				else:
					$"Sounds/Reverse 3".play()
			8:
				rng = randi_range(0,1)
				if rng==0:
					$"Sounds/Sket 1".play()
				else:
					$"Sounds/Sket 2".play()
			9:
				rng = randi_range(0,1)
				if rng==0:
					$"Sounds/Sket 3".play()
				else:
					$"Sounds/Sket 4".play()
	await get_tree().create_timer(0.5).timeout
	effect_transition = 1
	$CanvasLayer/indicator.frame = skill
	match skill:
		1:
			speed_multiplier = 0.3
			sleeping=true
			sleeping=false
			await get_tree().create_timer(4).timeout
			speed_multiplier = 1
		2:
			linear_damp = -0.25
			await get_tree().create_timer(2).timeout
			linear_damp = 1
		3:
			sleeping=true
			sleeping=false
			apply_central_force(Vector2(0,abs(gas+0.01)).rotated(rotation+deg_to_rad(90))*speed*speed_multiplier*2000)
		4:
			can_turn = false
			await get_tree().create_timer(4).timeout
			can_turn = true
		5:
			can_rotate = 1
			await get_tree().create_timer(3).timeout
			can_rotate = 1
		6:
			alpha=1.5
		7:
			reverse = -1
			await get_tree().create_timer(5).timeout
			reverse = 1
		8:
			forced_turn = -1
			await get_tree().create_timer(1).timeout
			forced_turn = 0
		9:
			forced_turn = 1
			await get_tree().create_timer(1).timeout
			forced_turn = 0

func wins():
	win = true
	$CanvasLayer/melon/elonani.play("anger")
	$Sounds/Lose1.play()
	$Sound_effects/Win.play()
	await get_tree().create_timer(2).timeout
	$Sounds/Driverwinsalenieuzywactego.play()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/selection_screen.tscn")
	
