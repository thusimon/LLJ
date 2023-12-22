extends CharacterBody2D

var active: bool = false
var speed: int = 200

func _ready():
	set_physics_process(false)
	call_deferred('setup')

func setup():
	await get_tree().physics_frame
	set_physics_process(true)
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos
	
func _physics_process(_delta):
	if active:
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		var tween = create_tween()
		tween.tween_property(self, 'rotation', direction.angle() + PI / 2, 0.4)
		move_and_slide()

func _on_watch_area_body_entered(_body):
	active = true

func _on_watch_area_body_exited(_body):
	active = false

func _on_navigation_timer_timeout():
	$NavigationAgent2D.target_position = Globals.player_pos
