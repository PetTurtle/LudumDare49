extends Node

export(float) var spawn_distance := 400
export(NodePath) var objects_path: NodePath

var enemies: Array
onready var objects = get_node(objects_path)

func _ready():
	enemies = [
		load("res://objects/Enemy/Enemy.tscn"),
	]


func _on_Timer_timeout():
	randomize()
	var spawn_vector = (Vector2.LEFT * spawn_distance).rotated(rand_range(0, 2 * PI))
	var enemy = enemies[rand_range(0, enemies.size())].instance()
	objects.add_child(enemy)
	enemy.global_position = spawn_vector
