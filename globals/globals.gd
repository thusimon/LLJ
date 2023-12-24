extends Node

signal stats_change(type: String)

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20:
	get:
		return laser_amount
	set(val):
		laser_amount = val
		stats_change.emit('laser')

var grenade_amount = 5:
	get:
		return grenade_amount
	set(val):
		grenade_amount = val
		stats_change.emit('grenade')

var play_vulnerable = true
var hp = 80:
	get:
		return hp
	set(val):
		if val >= hp:
			hp = min(val, 100)
		else:
			if play_vulnerable:
				hp = max(val, 0)
				play_vulnerable = false
				player_hit_sound.play()
				player_invulnerable_timer()
		stats_change.emit('hp')
		
var player_pos: Vector2 = Vector2.DOWN

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	play_vulnerable = true

func _ready():
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load('res://resources/audio/solid_impact.ogg')
	add_child(player_hit_sound)
