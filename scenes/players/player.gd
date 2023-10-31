extends CharacterBody2D


const speed = 300
var can_laser = true
var can_grenade = true
signal player_laser(pos)
signal player_grenade(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("Primary") and can_laser:
		can_laser = false
		$LaserTimer.start()
		player_laser.emit($ShootStartMarker.global_position)
	if Input.is_action_pressed("Secondary") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		player_grenade.emit($ShootStartMarker.global_position)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
