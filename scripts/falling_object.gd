extends StaticBody2D
var in_tip = false
var in_front = false
var in_back = false

@onready var car: RigidBody2D = $"../Car"





func _on_sprite_2d_2_has_fallen() -> void:
	$CPUParticles2D.emitting = true
	if in_tip == true:
		car.knocked_back(Vector2(-1,0)*10000)
	if in_back == true:
		car.knocked_back(Vector2(0,1)*10000)
	if in_front == true:
		car.knocked_back(Vector2(0,-1)*10000)


func _on_areatip_body_entered(body: Node2D) -> void:
	if body == car:
		in_tip = true


func _on_areatip_body_exited(body: Node2D) -> void:
	if body == car:
		in_tip = false


func _on_areafront_body_entered(body: Node2D) -> void:
	if body == car:
		in_front = true

func _on_areafront_body_exited(body: Node2D) -> void:
	if body == car:
		in_front = false


func _on_areaback_body_entered(body: Node2D) -> void:
	if body == car:
		in_back = true


func _on_areaback_body_exited(body: Node2D) -> void:
	if body == car:
		in_back = false
