extends Node

signal stats_change(type: String)

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

var hp = 80:
	get:
		return hp
	set(val):
		if val >= 100:
			hp = 100
		elif val <= 0:
			hp = 0
		else:
			hp = val
		stats_change.emit('hp')
		
var player_pos: Vector2 = Vector2.DOWN
