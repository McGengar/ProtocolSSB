extends Area2D


@onready var car: RigidBody2D = $"../Car"
var can_move = false  
var SPEED = 20


func _process(delta):
	if can_move : 
		position.x += delta*SPEED
	#if can_move:
		
		
	
func _on_body_entered(body: Node2D) -> void:
	if body == car :
		car.knocked_back(Vector2(0,1)*30000)
	
		



func _on_vision_box_body_entered(body: Node2D) -> void:
	if body == car :
		if can_move==false:
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D2.play("default")
			$AnimatedSprite2D3.play("default")
			can_move = true 
		
