extends Node2D

const laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const grenate_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_gate_body_entered(body):
	print('entered: ', body)


func _on_gate_body_exited(body):
	print('exit: ', body)


func _on_player_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation = direction.angle()
	laser.direction = direction
	$Projectiles.add_child(laser, true)

func _on_player_player_grenade(pos, direction):
	var grenade = grenate_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade, true)
