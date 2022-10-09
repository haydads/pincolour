extends Node


var target

var scenes : Dictionary = {
	"MainMenu" : "res://scenes/menu/main/MainMenu.tscn",
	"HowToPlay" : "res://scenes/how_to_play/HowToPlay.tscn",
	"Game" : "res://scenes/game/Game.tscn",
}

onready var animation_player : AnimationPlayer = get_node("CanvasLayer/Control/AnimationPlayer")
onready var animations : Array = animation_player.get_animation_list() #["None", "Fade"]

func _ready():
	transition_to("MainMenu")


func transition_to(scene : String, animation : String = "Fade"):
	if not scenes.has(scene):
		printerr("SceneManager: transition_to() unknown scene specified '%s'" % [scene])
		return
	
	if not animations.has(animation):
		printerr("SceneManager: transition_to() unknown animation specified '%s'" % [animation])
		return
	
	target = scenes.get(scene)
	animation_player.play(animation)


func change():
	get_tree().change_scene(target) # warning-ignore:return_value_discarded
	target = ""
