extends Area2D

export(int) var damage := 1

func _ready():
	connect("body_entered", self, "on_collision")

func on_collision(body: Object):
	if body.has_method("damage"):
		body.damage(damage)
