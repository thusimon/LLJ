extends CharacterBody2D

@export var max_speed: int = 400
var speed: int = max_speed
var can_laser: bool = true
var can_grenade: bool = true
signal player_laser(pos, direction)
signal player_grenade(pos, direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var move = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = move * speed
	move_and_slide()
	
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if Input.is_action_pressed("Primary") and can_laser:
		can_laser = false
		$GPUParticles2D.emitting = true
		$LaserTimer.start()
		# need to find the play direction, from current player position to current mouse position
		# Vect2_mousePos - Vect2_playerPos
		var direction = (mouse_pos - position).normalized()
		player_laser.emit($ShootStartMarker.global_position, direction)
	if Input.is_action_pressed("Secondary") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		var direction = (mouse_pos - position).normalized()
		player_grenade.emit($ShootStartMarker.global_position, direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
