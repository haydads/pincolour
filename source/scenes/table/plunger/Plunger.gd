extends Node2D


export var full_extension = 50
export var pull_time = 1.0
export var release_time = 0.05
export var keycode = "ui_down"

var release_speed = 0.0


func _ready():
	Global.connect("update_colour", self, "set_colour") # warning-ignore:return_value_discarded
	set_colour()


func _physics_process(delta):
	if Global.game_over: return
	if Input.is_action_just_released(keycode):
		get_node("%Sound").play()
	
	var y = $RigidBody2D.get_position().y
	if Input.is_action_pressed(keycode):
		# If the player is holding the pull key, slowly retract the plunger.
		if y < full_extension:
			y += (full_extension / pull_time) * delta
			if y > full_extension:
				y = full_extension
			$RigidBody2D.set_position(Vector2(0, y))
	else:
		# Otherwise allow the plunger to snap back.
		if y > 0.0:
			if release_speed == 0.0:
				release_speed = y / release_time
			y -= release_speed * delta
			if y <= 0.0:
				y = 0.0
				release_speed = 0.0
			$RigidBody2D.set_position(Vector2(0, y))


func set_colour():
	get_node("%Polygon2D").color = Global.colour
