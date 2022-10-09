extends Node2D

export (String, "left_flipper", "right_flipper", "both_flippers") var keycode = "left_flipper"
var snap_time : float = 0.1
var snap_angle : float = 80
var intermediate_time : float = 0.0
var default_key : String


func _ready():
	Global.connect("activate_modifier", self, "check_modifiers") # warning-ignore:return_value_discarded
	default_key = keycode
	if keycode == "left_flipper":
		snap_angle = -snap_angle


func _physics_process(delta):
	if Global.game_over: return
	if Input.is_action_just_pressed(keycode):
		get_node("%Sound").play()
		
	if Input.is_action_pressed(keycode):
		if intermediate_time < snap_time:
			intermediate_time += delta
			if intermediate_time > snap_time:
				intermediate_time = snap_time
			$RigidBody2D.set_rotation_degrees((intermediate_time / snap_time) * snap_angle)
	else:
		if intermediate_time > 0:
			intermediate_time -= delta
			if intermediate_time < 0:
				intermediate_time = 0
			$RigidBody2D.set_rotation_degrees((intermediate_time / snap_time) * snap_angle)


func check_modifiers(colour : String):
	keycode = default_key
	if colour == "Red":
		keycode = "both_flippers"
