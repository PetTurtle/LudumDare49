extends Area2D

var speed := 15
var separation := 16
var velocity := Vector2.ZERO

onready var bullet_scene := preload("res://objects/EnemyBullet/EnemyBullet.tscn")

func _physics_process(delta):
	for node in Tracker.tracked:
		if node != self:
			var distance = self.global_position.distance_to(node.global_position)
			if distance < separation:
				velocity += node.global_position.direction_to(global_position).normalized() * separation / distance * speed * 4 * delta
	
	if Globals.player != null:
		velocity += global_position.direction_to(Globals.player.global_position) * speed/2 * delta
		
	velocity = velocity.clamped(50)
	look_at(global_position + velocity)
	position += velocity * delta

func damage(amount: int):
	queue_free()

func _on_Fire_timeout():
	var bullet = bullet_scene.instance()
	get_tree().current_scene.objects.add_child(bullet)
	var shoot_dir := to_global(Vector2(1, 0)) - global_position
	bullet.global_position = global_position + shoot_dir * 6
	bullet.linear_velocity = velocity + shoot_dir * 50
	bullet.rotation = rotation
