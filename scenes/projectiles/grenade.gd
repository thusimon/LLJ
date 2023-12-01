extends RigidBody2D

@export var speed: int = 500
var is_explode: bool = false
var explode_range = 200

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if is_explode:
		var damangables = get_tree().get_nodes_in_group('Damagable')
		for damangable in damangables:
			var in_range = damangable.global_position.distance_to(global_position) < explode_range
			if in_range and 'hit' in damangable:
				damangable.hit()		

func explode():
	$AnimationPlayer.play("Explosion")
	is_explode = true
