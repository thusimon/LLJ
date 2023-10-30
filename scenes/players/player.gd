extends CharacterBody2D


const speed = 200
var can_laser = true
var can_grenade = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("Primary") and can_laser:
		can_laser = false;
		print('shoot laser')
		$LaserTimer.start()
	if Input.is_action_pressed("Secondary") and can_grenade:
		can_grenade = false;
		print('shoot grenade')
		$GrenadeTimer.start()


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
