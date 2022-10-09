extends Node2D


var active : bool = false
onready var mask : Area2D = get_node("%Area2D")
onready var shape := get_node("%Shape")
onready var light : MeshInstance2D = get_node("%Light")


func _ready():
	mask.connect("body_entered", self, "on_hit") # warning-ignore:return_value_discarded
	Global.connect("update_colour", self, "set_colour") # warning-ignore:return_value_discarded
	shape.visible = active


func on_hit(_body):
	active = !active
	activate()


func set_colour():
	light.modulate = Global.colour


func activate():
	shape.visible = active
