extends Node2D

signal enemy_spawned(enemy_instance)

var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var timer = $Timer

@onready var spawn_positions = $SpawnPositions

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func _process(delta: float) -> void:
	pass
	
func _on_timer_timeout():
	_spawn_enemy()
	
func _spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
	
