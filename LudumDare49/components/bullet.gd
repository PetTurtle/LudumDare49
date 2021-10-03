extends Area2D

export(int) var damage := 1

onready var linear_velocity := Vector2.ZERO


func _ready():
	connect("body_entered", self, "on_collision")
	connect("area_entered", self, "on_collision")

func _physics_process(delta):
	global_position += linear_velocity * delta

func on_collision(body: Object):
	if body.has_method("damage"):
		body.damage(damage)
	
	queue_free()

