extends Node2D

export(float) var spawn_distance := 400
export(float) var attack_distance := 90
export(NodePath) var objects_path: NodePath

var asteroids: Array
onready var timer: Timer = $Timer
onready var objects = get_node(objects_path)

func _ready():
	asteroids = [
		load("res://objects/Asteroid/asteroid.tscn"),
		load("res://objects/Asteroid/asteroid.tscn"),
		load("res://objects/Asteroid/asteroid_l.tscn"),
		load("res://objects/Asteroid/asteroid_l.tscn"),
		load("res://objects/Asteroid/asteroid_l.tscn"),
		load("res://objects/Asteroid/asteroid_x_l.tscn"),
		load("res://objects/Asteroid/asteroid_x_l.tscn"),
		load("res://objects/Satilite/Satilite.tscn")
	]


func _on_Timer_timeout():
	randomize()
	var spawn_vector = (Vector2.LEFT * spawn_distance).rotated(rand_range(0, 2 * PI))
	var attack_vector = Vector2(rand_range(-attack_distance, attack_distance), rand_range(-attack_distance, attack_distance))
	var asteroid = asteroids[rand_range(0, asteroids.size())].instance()
	objects.add_child(asteroid)
	asteroid.global_position = spawn_vector
	asteroid.linear_velocity = spawn_vector.direction_to(attack_vector).normalized() * rand_range(25, 50)
	timer.wait_time = max(4, timer.wait_time - 0.25)
