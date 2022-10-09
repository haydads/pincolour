extends RigidBody2D


export var force : float = 800.0
export var score : int = 50


func _ready():
	Global.connect("update_colour", self, "update_colour") # warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_kicker_hit") # warning-ignore:return_value_discarded
	set_colour(Global.colour)


func _on_kicker_hit(ball):
	ball.apply_central_impulse(Vector2.LEFT.rotated(get_global_rotation()) * force)
	Global.score += score * Global.multiplier
	
	get_node("%Sound").play()
	set_colour(Color(1, 1, 1, 1))
	yield(get_tree().create_timer(0.1), "timeout")
	set_colour(Global.colour)


func set_colour(colour : Color):
	for child in $Shape.get_children():
		child.modulate = colour


func update_colour():
	set_colour(Global.colour)
