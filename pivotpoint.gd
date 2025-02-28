extends Sprite2D
signal has_fallen
func _physics_process(delta: float) -> void:
	rotation = lerp_angle(rotation, deg_to_rad(-90), 4*delta)
	if rotation <= -1.5:
		emit_signal("has_fallen")
		print(rotation)
