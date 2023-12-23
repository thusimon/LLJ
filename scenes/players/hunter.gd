extends CharacterBody2D

var active: bool = false
var speed: int = 200
var in_range: bool = false
var can_attack: bool = true
var vulnerable: bool = true
var health: int = 50

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
	$AnimationPlayer.play('walk')

func _on_watch_area_body_exited(_body):
	active = false

func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos

func _on_attack_area_body_entered(_body):
	in_range = true
	if can_attack:
		can_attack = false
		$Timers/AttackTimer.start()
		$AnimationPlayer.play('attack')

func _on_attack_area_body_exited(_body):
	in_range = false

func _on_attack_timer_timeout():
	can_attack = true

func _on_hit_timer_timeout():
	vulnerable = true
	$Skeleton2D.material.set_shader_parameter('progress', 0)
	$GPUParticles2D.emitting = false

func hit():
	if vulnerable:
		vulnerable = false
		$Timers/HitTimer.start()
		$Skeleton2D.material.set_shader_parameter('progress', 0.5)
		$GPUParticles2D.emitting = true
		health -= 10
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()

func attack():
	if in_range:
		Globals.hp -= 20
