extends Sprite2D
var sigma_detected = false
var has_fallen1 = false
signal has_fallen
func _physics_process(delta: float) -> void:
	if sigma_detected:
		rotation = lerp_angle(rotation, deg_to_rad(-90), 5*delta)
		if rotation <= -1.5 and not has_fallen1:
			has_fallen1 = true
			emit_signal("has_fallen")
			sigma_detected = false


func _on_player_detection_body_entered(body: Node2D) -> void:
	sigma_detected = true
