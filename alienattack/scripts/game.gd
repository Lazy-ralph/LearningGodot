extends Node2D

var lives = 3
var scores = 0

@onready var player = $Player

@onready var enemy_spawner = $EnemySpawner

@onready var deathzone = $Deathzone

func _ready() -> void:
	deathzone.area_entered.connect(_on_deathzone_area_entered)
	player.took_damage.connect(_on_player_took_damage)
	enemy_spawner.enemy_spawned.connect(_on_enemy_spawner_enemy_spawned)
	
func _process(delta: float) -> void:
	pass
	
func _on_deathzone_area_entered(area):
	area.die()
	
func _on_player_took_damage():
	lives += -1
	if lives == 0:
		print("game over")
		player.die()
	else:
		print(lives)
		
func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.died.connect(_on_enemy_died)
	add_child(enemy_instance)
	
func _on_enemy_died():
	scores += 100
	print(scores)
