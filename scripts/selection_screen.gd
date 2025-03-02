extends Node2D
@onready var txtg: Sprite2D = $Txtg
@onready var txtw: Sprite2D = $Txtw
@onready var txtb: Sprite2D = $Txtb
@onready var txtr: Sprite2D = $Txtr


var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_grassmapbutt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_wintmapbutt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/wintermain.tscn")



func _on_bizonmapbutt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/questionmain.tscn")


func _on_randombutt_pressed() -> void:
	var my_random_number = rng.randi_range(0,2)
	if my_random_number == 0:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	elif my_random_number == 1:
		get_tree().change_scene_to_file("res://scenes/wintermain.tscn")
	elif my_random_number == 2:
		get_tree().change_scene_to_file("res://scenes/questionmain.tscn")


func _on_grassmapbutt_mouse_entered() -> void:
	txtg.visible = true


func _on_grassmapbutt_mouse_exited() -> void:
	txtg.visible = false


func _on_wintmapbutt_mouse_entered() -> void:
	txtw.visible = true


func _on_wintmapbutt_mouse_exited() -> void:
	txtw.visible = false


func _on_bizonmapbutt_mouse_entered() -> void:
	txtb.visible = true


func _on_bizonmapbutt_mouse_exited() -> void:
	txtb.visible = false


func _on_randombutt_mouse_entered() -> void:
	txtr.visible = true


func _on_randombutt_mouse_exited() -> void:
	txtr.visible = false


func _on_backbutt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
