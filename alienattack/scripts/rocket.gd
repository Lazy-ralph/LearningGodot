extends Area2D

@export var speed = 300

@onready var visible_notifier = $VisibleNotifier

func _ready():
	visible_notifier.screen_exited.connect(_on_screen_exited)

func _physics_process(delta):
	global_position.x += speed * delta

func _on_screen_exited():
	queue_free()
