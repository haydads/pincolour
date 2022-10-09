extends Control


var time : float = 0.0


func _ready():
	Global.colour_queue = []
	Global.change_colour()
	for button in get_tree().get_nodes_in_group("Actions"):
		button.connect("pressed", self, "on_button_pressed", [button.get_name()])


func on_button_pressed(_button):
	match _button:
		"Play": SceneManager.transition_to("Game")
		"HowToPlay": SceneManager.transition_to("HowToPlay")


func _process(delta : float):
	time += delta
	if time >= 10.0:
		Global.change_colour()
		time = 0.0
