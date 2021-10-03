extends Light2D

export(bool) var on_earth := false

var sight := 128
var active := false
onready var space_state := get_world_2d().direct_space_state


func _ready():
	if on_earth:
		Radars.add_radar(self)
		active = true

func _process(delta):
	if active:
		texture_scale = min(0.5, texture_scale + delta * 10)
	else:
		texture_scale = max(0, texture_scale - delta * 10)

func _get_sight_dist(scale: bool):
	if scale:
		return texture_scale * sight
	return sight

func can_see(node: Node2D, scale: bool = false) -> bool:
	var result = space_state.intersect_ray(self.global_position, node.global_position, [], 14)
	return not result.has("collider") #and self.global_position.distance_to(node.global_position) < _get_sight_dist(scale)

func can_see_player() -> bool:
	var result = space_state.intersect_ray(self.global_position, Globals.player.global_position)
	var distance = self.global_position.distance_to(Globals.player.global_position)
	return distance < 8 or (result.has("collider") and result["collider"] == Globals.player and distance < _get_sight_dist(true))

func _exit_tree():
	Radars.remove_radar(self)
