extends Node2D
class_name LevelBase

const laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
const grenate_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
const reward_scene: PackedScene = preload("res://scenes/items/reward.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var items = get_tree().get_nodes_in_group('Items')
	for item in items:
		item.connect('open', _on_item_opened)

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

func _on_item_opened(pos: Vector2, direction: Vector2):
	var reward = reward_scene.instantiate()
	reward.position = pos
	$Objects.call_deferred("add_child", reward)
	var distance = randi_range(120, 200)
	var new_pos = pos + (distance * direction)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(reward, "scale", Vector2(1, 1), 0.5).from(Vector2(0, 0))
	tween.tween_property(reward, "position", new_pos, 0.5)
		
	
