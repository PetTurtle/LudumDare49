class_name MovementController
extends Node

export(float) var move_speed: float = 25
export(float) var turn_speed: float = 2

var active: bool = true
onready var body: RigidBody2D = get_parent()

func _physics_process(delta) -> void:
	if active:
		var move_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		var move_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		body.linear_velocity += Vector2(move_x, move_y) * move_speed * delta
		body.look_at(body.get_global_mouse_position())
