extends RigidBody2D

signal died

export(NodePath) var earth_path: NodePath
export(NodePath) var fire_bar_1_path: NodePath
export(NodePath) var fire_bar_2_path: NodePath
export(Color) var active_color: Color
export(Color) var inactive_color: Color
export(Color) var power_up_color: Color

var active := true
var fire_1_ready := true
var fire_2_ready := true
var in_power_up := false
onready var sprite := $Sprite2D
onready var controller := $MovementController
onready var signal_delay := $SignalDelay
onready var cam := $Camera2D
onready var fire_1_t = $Fire1
onready var fire_2_t = $Fire2
onready var fire_1_s = $Fire1Sound
onready var fire_2_s = $Fire2Sound
onready var power_up_t = $PowerUPTime
onready var power_up_s = $PowerUpSound
onready var fire_bar_1: ProgressBar = get_node(fire_bar_1_path)
onready var fire_bar_2: ProgressBar = get_node(fire_bar_2_path)
onready var earth: Planet = get_node(earth_path)
onready var rood_scene := preload("res://objects/RadarRood/RadarRood.tscn")
onready var bullet_scene := preload("res://objects/PlayerBullet/PlayerBullet.tscn")
onready var death_explosion := preload("res://objects/Explosions/player_die.tscn")


func _init():
	Globals.player = self

func _ready():
	yield(get_tree().create_timer(0.05), "timeout")
	global_position = earth.global_position + (Vector2.ONE * earth.radius * 1.5).rotated(earth.rotation + PI/2)
	rotation = earth.rotation + PI/1.25
	cam.smoothing_enabled = false
	yield(get_tree().create_timer(0.1), "timeout")
	cam.smoothing_enabled = true

func _process(delta):
	if in_power_up:
		sprite.modulate = power_up_color
		controller.active = true
		
	fire_bar_1.max_value = fire_1_t.wait_time
	fire_bar_1.value = fire_1_t.wait_time - fire_1_t.time_left
	fire_bar_2.max_value = fire_2_t.wait_time
	fire_bar_2.value = fire_2_t.wait_time -fire_2_t.time_left
	
	if controller.active == false:
		return
	
	if Input.is_action_pressed("fire_1") and fire_1_ready:
		var bullet = bullet_scene.instance()
		get_tree().current_scene.objects.add_child(bullet)
		var shoot_dir := to_global(Vector2(1, 0)) - global_position
		bullet.global_position = global_position + shoot_dir * 6
		bullet.linear_velocity = linear_velocity + shoot_dir * 120
		bullet.rotation = rotation
		fire_1_ready = false
		fire_1_t.start()
		fire_1_s.play()
	
	if Input.is_action_pressed("fire_2") and fire_2_ready:
		
		var rood: Node2D = rood_scene.instance()
		get_tree().current_scene.objects.add_child(rood)
		var shoot_dir := to_global(Vector2(1, 0)) - global_position
		rood.global_position = global_position + shoot_dir * 6
		rood.launch_velocity = linear_velocity + shoot_dir * 60
		rood.rotation = rotation
		fire_2_ready = false
		fire_2_t.start()
		fire_2_s.play()

func set_radar_signal(state: bool):
	if in_power_up:
		sprite.modulate = power_up_color
		active = state
		return
	
	if active != state:
		active = state
		if state:
			sprite.modulate = active_color
			controller.active = state
		else:
			signal_delay.start()

func damage(amount: int):
	queue_free()

func power_up():
	active = true
	controller.active = true
	fire_1_t.wait_time = 0.08
	power_up_t.start()
	power_up_s.play()
	in_power_up = true
	sprite.modulate = power_up_color

func _on_SignalDelay_timeout():
	if active == false:
		sprite.modulate = inactive_color
		controller.active = false

func _exit_tree():
	Globals.effects.spawn(death_explosion, global_position, rotation)
	Globals.player = null
	emit_signal("died")


func _on_Fire1_timeout():
	fire_1_ready = true


func _on_Fire2_timeout():
	fire_2_ready = true


func _on_PowerUPTime_timeout():
	fire_1_t.wait_time = 0.25
	in_power_up = false
	sprite.modulate = active_color
	if active:
		sprite.modulate = active_color
		controller.active = active
	else:
		signal_delay.start()
