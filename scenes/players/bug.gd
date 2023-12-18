extends CharacterBody2D

var speed: int = 200
var active: bool = false
var can_attack: bool = false
var health: int = 20
var vulnerable: bool = true;

func hit():
	if vulnerable:
		vulnerable = false
		health -= 10
		$AnimatedSprite2D.material.set_shader_parameter('progress', 0.8)
		$Particles/HitParticle.emitting = true
		$Timers/HitTimer.start()
		print('bug hit')
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _process(_delta):
	if active:
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		look_at(Globals.player_pos)
		move_and_slide()

func _on_watch_area_body_entered(_body):
	active = true
	$AnimatedSprite2D.play('walk')

func _on_watch_area_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()

func _on_attack_area_body_entered(_body):
	can_attack = true
	$AnimatedSprite2D.play('attack')

func _on_attack_area_body_exited(_body):
	can_attack = false

func _on_animated_sprite_2d_animation_finished():
	if can_attack:
		Globals.hp -= 10
		$Timers/AttackTimer.start()
		
func _on_attact_timer_timeout():
	$AnimatedSprite2D.play('attack')

func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter('progress', 0)
	$Particles/HitParticle.emitting = false
