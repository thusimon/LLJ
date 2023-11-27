extends Area2D

var rotation_speed = 3
var options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'hp']
var Red: Color = Color(0.8, 0.2, 0.2)
var Green: Color = Color(0.2, 0.8, 0.2)
var Blue: Color = Color(0.2, 0.2, 0.8)

var type
func _ready():
	type = options[randi() % len(options)]
	match type:
		'laser':
			$Sprite2D.modulate = Blue
		'grenade':
			$Sprite2D.modulate = Red
		'hp':
			$Sprite2D.modulate = Green
		_:
			print('unknown type')

func _process(delta):
	rotation += delta * rotation_speed

func _on_body_entered(body):
	if 'get_reward' in body:
		body.get_reward(type)
		queue_free()
