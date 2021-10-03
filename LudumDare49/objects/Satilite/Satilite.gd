extends RigidBody2D

onready var explode_scene := preload("res://objects/Explosions/asteroid_die.tscn")

func _ready():
	randomize()
	rotation = rand_range(0, 2*PI)
	#angular_velocity = rand_range(-0.5, 0.5)


func _on_Area2D_area_entered(area):
	Globals.effects.spawn(explode_scene, global_position, rotation)
	queue_free()


func _on_Area2D_body_entered(body):
	if body.has_method("power_up"):
		body.power_up()
		Globals.add_score(3)

	Globals.effects.spawn(explode_scene, global_position, rotation)
	queue_free()

