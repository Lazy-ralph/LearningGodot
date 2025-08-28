extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("body out")
