extends Area2D


onready var arrow : Polygon2D = get_node("%Arrow")



func _ready():
	Global.connect("update_colour", self, "set_colour") # warning-ignore:return_value_discarded



func set_colour():
	arrow.modulate = Global.colour

