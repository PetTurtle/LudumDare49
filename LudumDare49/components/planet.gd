class_name Planet
extends KinematicBody2D

export(int) var radius := 8
export(float) var spin := 0.1


func _ready():
	var occluder := CircleOccluder.new(radius)
	add_child(occluder)
	var collision := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = radius
	collision.shape = circle
	add_child(collision)
	
	randomize()
	rotation = rand_range(0, 2*PI)
	
	
func _physics_process(delta):
	rotate(spin * delta)

func _enter_tree():
	Tracker.add_node(self)

func _exit_tree():
	Tracker.remove_node(self)
