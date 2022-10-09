extends RigidBody2D


onready var center = get_node("%Center")
onready var ring = get_node("%Ring")

export var force : float = 500.0
export var score : int = 100


func _ready():
	Global.connect("update_colour", self, "update_colour") # warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_bumper_hit") # warning-ignore:return_value_discarded
	set_colour(Global.colour)


func _on_bumper_hit(ball):
	var force_direction = ball.get_position() - get_position()
	ball.apply_central_impulse(force_direction.normalized() * force)
	Global.score += score * Global.multiplier
	
	get_node("%Sound").play()
	set_colour(Color(1, 1, 1, 1))
	yield(get_tree().create_timer(0.1), "timeout")
	set_colour(Global.colour)


func set_colour(colour : Color):
	center.modulate = colour
	ring.modulate = colour


func update_colour():
	set_colour(Global.colour)
