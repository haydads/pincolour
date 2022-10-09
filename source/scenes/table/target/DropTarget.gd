extends Node2D


onready var top = get_node("%Top")
onready var center = get_node("%Center")
onready var bottom = get_node("%Bottom")
var active : bool = true


func _ready():
	Global.connect("update_colour", self, "set_colour") # warning-ignore:return_value_discarded
	Global.connect("update_balls", self, "reset") # warning-ignore:return_value_discarded
	top.connect("body_entered", self, "_on_hit", [top.name]) # warning-ignore:return_value_discarded
	center.connect("body_entered", self, "_on_hit", [center.name]) # warning-ignore:return_value_discarded
	bottom.connect("body_entered", self, "_on_hit", [bottom.name]) # warning-ignore:return_value_discarded
	set_colour()


func _on_hit(_ball, hit_target):
	get_node("%Sound").play()
	
	var target = get_node(hit_target)
	target.visible = false
	Global.score += 10 * Global.multiplier
	check()


func set_colour():
	top.modulate = Global.colour
	center.modulate = Global.colour
	bottom.modulate = Global.colour


func check():
	if (not top.visible) and (not center.visible) and (not bottom.visible) and active:
		active = false
		Global.score += 220 * Global.multiplier
		if Global.colour_name == "Yellow": Global.multiplier += 0.2
		else: Global.multiplier += 0.1
		yield(get_tree().create_timer(5.0), "timeout")
		reset()


func reset():
	top.visible = true
	center.visible = true
	bottom.visible = true
	active = true
