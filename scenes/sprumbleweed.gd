extends Sprite2D


func _physics_process(delta: float) -> void:
	rotation = lerp_angle(rotation, deg_to_rad(360), 5*delta)
	
