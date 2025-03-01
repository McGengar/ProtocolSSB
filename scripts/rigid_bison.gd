extends StaticBody2D
var entered = false
var bison_speed = 0.01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not entered:
		for i in range(0,300):
			entered = true
			await get_tree().create_timer(bison_speed).timeout
			if rotation == 0:
				position.x += 1
			elif rotation == deg_to_rad(-90):
				position.y += 1
			elif rotation == deg_to_rad(90):
				position.y -= 1
