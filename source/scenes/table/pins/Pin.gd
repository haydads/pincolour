extends Node2D


onready var shape = get_node("%Shape")

func _ready():
	Global.connect("update_colour", self, "update_colour") # warning-ignore:return_value_discarded
	set_colour(Global.colour)


func set_colour(colour : Color):
	for child in shape.get_children():
		child.modulate = colour


func update_colour():
	set_colour(Global.colour)
