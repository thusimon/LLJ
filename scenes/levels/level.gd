extends Node2D
class_name LevelBase

const laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const grenate_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation = direction.angle()
	laser.direction = direction
	$Projectiles.add_child(laser, true)
	$UI.update_laser_amount()

func _on_player_player_grenade(pos, direction):
	var grenade = grenate_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade, true)
	$UI.update_grenade_amount()


func _on_house_player_entered():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, 'zoom', Vector2(0.8, 0.8), 1)


func _on_house_player_exited():
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, 'zoom', Vector2(0.6, 0.6), 1)
