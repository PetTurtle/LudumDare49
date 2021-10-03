extends RigidBody2D

export(NodePath) var c_polygon_path: NodePath
export(int) var size := 1

onready var c_polygon: CollisionPolygon2D = get_node(c_polygon_path)

func _ready():
	randomize()
	angular_velocity = rand_range(-10, 10)
	var light_occluder := LightOccluder2D.new()
	add_child(light_occluder)
	light_occluder.occluder = OccluderPolygon2D.new()
	light_occluder.occluder.polygon = c_polygon.polygon


func damage(amount: int):
	queue_free()

func _enter_tree():
	Tracker.add_node(self)

func _exit_tree():
	Tracker.remove_node(self)
