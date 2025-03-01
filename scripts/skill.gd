extends AnimatedSprite2D
@export var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	value = randi_range(1,9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame = value
