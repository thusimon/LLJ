extends CanvasLayer

@onready var LaserLabel: Label = $LaserCounter/VBoxContainer/Label
@onready var GrenadeLabel: Label = $GrenadeCounter/VBoxContainer/Label
@onready var LaserIcon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var GrenadeIcon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

var Green: Color = Color("6BBFA3")
var Red: Color = Color("CC2211")

func _ready():
	update_laser_amount()
	update_grenade_amount()

func update_laser_amount():
	LaserLabel.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, LaserLabel, LaserIcon)
	
func update_grenade_amount():
	GrenadeLabel.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, GrenadeLabel, GrenadeIcon)

func update_color(amount: int, label: Label, icon: TextureRect):
	if amount <= 0:
		label.modulate = Red
		icon.modulate = Red
	else:
		label.modulate = Green
		icon.modulate = Green
