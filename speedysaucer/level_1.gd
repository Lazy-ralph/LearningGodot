extends Node2D


func _on_area_2d_body_exited(body: Node2D) -> void:
	get_tree().reload_current_scene.call_deferred()
