class_name Orbit
extends Node

export(float) var speed := 0.1
export(NodePath) var target_path: NodePath

var angle: float
var radius: float = 16

onready var parent: Node2D = get_parent()
onready var target: Node2D = get_node(target_path)
onready var orbit_line_scene := preload("res://objects/OrbitLine/orbit_line.tscn")

func _ready():
	randomize()
	angle = rand_range(0, 2 * PI)
	radius = target.global_position.distance_to(parent.global_position)
	var orbit_line = orbit_line_scene.instance()
	var points := PoolVector2Array()
	for i in range(0, 360, 360/32):
		var point := Vector2(radius*cos(PI * i / 180.0), radius*sin(PI * i / 180.0))
		points.append(point)
	var point := Vector2(radius*cos(PI * 0 / 180.0), radius*sin(PI * 0 / 180.0))
	points.append(point)
	orbit_line.points = points
	target.add_child(orbit_line)

func _physics_process(delta):
	angle += speed * delta
	var offset := Vector2(radius*cos(PI * angle), radius*sin(PI * angle))
	parent.global_position = target.global_position + offset
