extends Area2D

export(int) var damage := 1
export(String) var explosion_path: String

var explosion_scene: PackedScene

onready var linear_velocity := Vector2.ZERO


func _ready():
	explosion_scene = load(explosion_path)
	connect("body_entered", self, "on_collision")
	connect("area_entered", self, "on_collision")

func _physics_process(delta):
	global_position += linear_velocity * delta

func on_collision(body: Object):
	if body.has_method("damage"):
		body.damage(damage)
	
	Globals.effects.spawn(explosion_scene, global_position, rotation)
	queue_free()



func _on_TimeOut_timeout():
	Globals.effects.spawn(explosion_scene, global_position, rotation)
	queue_free()
