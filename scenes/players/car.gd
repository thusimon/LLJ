extends PathFollow2D

var active: bool = false
var path_speed: float = 0.02
@onready var ray1: RayCast2D = $Turret/RayCast2D1
@onready var ray2: RayCast2D = $Turret/RayCast2D2
@onready var line1: Line2D = $Turret/RayCast2D1/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D
@onready var gun_fire1: Sprite2D = $Turret/GunFire1
@onready var gun_fire2: Sprite2D = $Turret/GunFire2

func _ready():
	line1.add_point(ray1.target_position)
	line2.add_point(ray2.target_position)

func _process(delta):
	progress_ratio += path_speed * delta
	if active:
		$Turret.look_at(Globals.player_pos)

func _on_watch_area_body_entered(_body):
	active = true
	$AnimationPlayer.play('laser_load')

func _on_watch_area_body_exited(_body):
	active = false
	$AnimationPlayer.pause()
	var tween =  create_tween()
	tween.set_parallel(true)
	tween.tween_property(line1, 'width', 0, randf_range(0.1, 0.5))
	tween.tween_property(line2, 'width', 0, randf_range(0.1, 0.5))
	await tween.finished
	$AnimationPlayer.stop()

func shoot():
	gun_fire1.modulate.a = 1
	gun_fire2.modulate.a = 1
	Globals.hp -= 20
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire1, 'modulate:a', 0, randf_range(0.1, 0.5))
	tween.tween_property(gun_fire2, 'modulate:a', 0, randf_range(0.1, 0.5))
