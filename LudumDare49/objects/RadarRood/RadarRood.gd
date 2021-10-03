extends Node2D


export(int) var speed = 80

var attached: Node2D = null
var velocity := Vector2(speed, 0)
var launch_velocity: Vector2

onready var area := $AttachZone
onready var radar := $Radar


func _physics_process(delta):
	position += launch_velocity * delta + (velocity * delta).rotated(rotation)
	if attached != null:
		activate()

func activate():
	var curr_pos = global_position
	var curr_rotation = global_rotation
	get_parent().remove_child(self)
	attached.add_child(self)
	global_position = curr_pos
	global_rotation = curr_rotation
	set_physics_process(false)
	area.queue_free()
	Radars.add_radar(radar)

func _on_AttachZone_body_entered(body):
	attached = body
