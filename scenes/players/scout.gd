extends CharacterBody2D

var is_in_range: bool = false
var gun_idx: int = 0
var can_shoot: bool = true
var vulnerable: bool = true
@export var hp: int = 30
@onready var shoot_timer = $Timers/ShootTimer
@onready var vuln_timer = $Timers/VulnTimer
signal scout_laser(pos: Vector2, direction: Vector2)

func _process(_delta):
	if is_in_range:
		look_at(Globals.player_pos)
		shoot()

func _on_watch_area_body_entered(_body):
	is_in_range = true

func _on_watch_area_body_exited(_body):
	is_in_range = false

func shoot():
	if can_shoot:
		can_shoot = false
		shoot_timer.start()
		gun_idx = (gun_idx+1) % 2
		var marker = $LaserPosition.get_children()[gun_idx]
		# the direction is pointing from scout to player
		var direction = (Globals.player_pos - position).normalized()
		scout_laser.emit(marker.global_position, direction) 
	
func hit():
	if vulnerable:
		vulnerable = false
		vuln_timer.start()
		hp -= 10
		if hp <= 0:
			queue_free()

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_vuln_timer_timeout():
	vulnerable = true
