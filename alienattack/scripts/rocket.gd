extends Area2D

@export var speed = 300

@onready var visible_notifier = $VisibleNotifier

@onready var rocket = $"."

func _ready():
	visible_notifier.screen_exited.connect(_on_screen_exited)
	rocket.area_entered.connect(_on_area_entered)
	
func _physics_process(delta):
	global_position.x += speed * delta

func _on_screen_exited():
	queue_free()
	
func _on_area_entered(area):
	queue_free()
	area.die()
	
	
