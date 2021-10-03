class_name Sprite2D
extends Sprite

export(int) var layers: int = 1
export(Vector2) var layer_offset := Vector2(0, 1)
export(Color) var layer_color: Color
export(NodePath) var root_path: NodePath

var sprites: Array 

onready var root: Node2D = get_node(root_path)
onready var root_offset: Vector2 = position

func _ready():
	for i in layers:
		var sprite := Sprite.new()
		add_child(sprite)
		sprite.texture = texture
		sprite.modulate = layer_color
		sprite.show_behind_parent = true
		sprite.global_position = global_position + root_offset
		sprites.append(sprite)


func _process(_delta):
	global_position = root.global_position + root_offset.rotated(root.rotation) - layer_offset
	var count: float = layers
	for sprite in sprites:
		sprite.global_position = global_position + layer_offset * (count / layers)
		count = count - 1

