extends Control


var time : float = 0.0
var percent : float = 0.1

onready var progress = get_node("%TextureProgress")
onready var label = get_node("%Label")


func _ready():
	Global.connect("update_colour", self, "set_colour") # warning-ignore:return_value_discarded
	Global.connect("update_multiplier", self, "set_multiplier") # warning-ignore:return_value_discarded
	set_colour()
	set_multiplier()


func _process(delta):
	if Global.game_over: return
	if Global.colour_name == "Magenta": delta *= 2
	time += delta
	percent = (time / 10.0)
	progress.value = percent * 1000
	if percent >= 1.0:
		Global.change_colour()
		#set_colour()
		#yield(get_tree(), "idle_frame")
		time = 0.0


func set_colour():
	progress.modulate = Global.colour


func set_multiplier():
	label.text = str(Global.multiplier) + "x"
