extends RigidBody2D

export(int) var health := 4
export(NodePath) var c_polygon_path: NodePath
export(int) var size := 1

var sub_divs: Array

onready var c_polygon: CollisionPolygon2D = get_node(c_polygon_path)
onready var explode_scene := preload("res://objects/Explosions/asteroid_die.tscn")


func _ready():
	randomize()
	angular_velocity = rand_range(-0.5, 0.5)
	var light_occluder := LightOccluder2D.new()
	add_child(light_occluder)
	light_occluder.occluder = OccluderPolygon2D.new()
	light_occluder.occluder.polygon = c_polygon.polygon
	
	sub_divs = [
		[
			load("res://objects/Asteroid/asteroid.tscn"),
		],
		[
			load("res://objects/Asteroid/asteroid_l.tscn"),
		]
	]


func damage(amount: int):
	health -= amount
	if health <= 0:
		if amount < 10:
			Globals.add_score(1)
		queue_free()

func _enter_tree():
	Tracker.add_node(self)

func _exit_tree():
	if size != -1:
		spawn_subdiv()
		spawn_subdiv()
		spawn_subdiv()

	Globals.effects.spawn(explode_scene, global_position, rotation)
	Tracker.remove_node(self)

func spawn_subdiv():
	var asteroid = sub_divs[size][rand_range(0, sub_divs[size].size())].instance()
	get_tree().current_scene.objects.call_deferred("add_child", asteroid)
	asteroid.global_position = global_position
	asteroid.linear_velocity = Vector2.UP.rotated(rand_range(0, 2*PI))  * rand_range(35, 50)


func _on_Area2D_body_entered(body):
	if body.has_method("damage"):
		body.damage(1)
	queue_free()
