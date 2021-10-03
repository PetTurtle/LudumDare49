extends Node2D


func _ready():
	Globals.audio = self

func spawn(audio_scene: PackedScene, point: Vector2):
	var audio := audio_scene.instance()
	add_child(audio)
	audio.global_position = point
