extends CharacterBody2D

@export var max_speed: int = 400
var speed: int = max_speed
var can_laser: bool = true
var can_grenade: bool = true
signal player_laser(pos, direction)
signal player_grenade(pos, direction)

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var move = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = move * speed
	move_and_slide()
	Globals.player_pos = position
	
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if Input.is_action_pressed("Primary") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		can_laser = false
		$GPUParticles2D.emitting = true
		$LaserTimer.start()
		# need to find the play direction, from current player position to current mouse position
		# Vect2_mousePos - Vect2_playerPos
		var direction = (mouse_pos - position).normalized()
		player_laser.emit($ShootStartMarker.global_position, direction)
	if Input.is_action_pressed("Secondary") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeTimer.start()
		var direction = (mouse_pos - position).normalized()
		player_grenade.emit($ShootStartMarker.global_position, direction)

func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true

func get_reward(type: String) -> void:
	match type:
		'laser':
			Globals.laser_amount += 10
		'grenade':
			Globals.grenade_amount += 1
		'hp':
			Globals.hp += 20

func hit():
	Globals.hp -= 10
