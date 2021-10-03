extends Node2D


func _ready():
	Globals.effects = self

func spawn(effect_scene: PackedScene, point: Vector2, rotation: float = 0):
	var effect := effect_scene.instance()
	add_child(effect)
	effect.global_position = point
	effect.rotation = rotation
