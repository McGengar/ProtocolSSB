extends CollisionShape2D







func _on_sprite_2d_2_has_fallen() -> void:
	await get_tree().create_timer(0.25).timeout
	disabled = false
