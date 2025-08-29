extends Node2D

var lives = 3
var score = 0
var game_over_screen = preload("res://scenes/game_over_screen.tscn")

@onready var player = $Player
@onready var enemy_spawner = $EnemySpawner
@onready var deathzone = $Deathzone
@onready var hud =$UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_took_damage_sound = $PlayerTookDamageSound

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)
	deathzone.area_entered.connect(_on_deathzone_area_entered)
	player.took_damage.connect(_on_player_took_damage)
	enemy_spawner.enemy_spawned.connect(_on_enemy_spawner_enemy_spawned)
	
func _on_deathzone_area_entered(area):
	area.queue_free()
	
func _on_player_took_damage():
	lives += -1
	player_took_damage_sound.play()
	hud.set_lives(lives)
	if lives == 0:
		player.die()
		
		await get_tree().create_timer(1).timeout
		
		var game_over_instance = game_over_screen.instantiate()
		game_over_instance.set_score(score)
		ui.add_child(game_over_instance)
		
func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.died.connect(_on_enemy_died)
	add_child(enemy_instance)
	
func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance: Variant) -> void:
	path_enemy_instance.get_node("PathFollow2D/Enemy").died.connect(_on_enemy_died)
	add_child(path_enemy_instance)
