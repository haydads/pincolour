extends RigidBody2D


const MAX_VELOCITY : float = 1500.0


func _ready():
	Global.connect("activate_modifier", self, "check_modifiers") # warning-ignore:return_value_discarded


func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	if velocity.length() > MAX_VELOCITY:
		state.set_linear_velocity(velocity.limit_length(MAX_VELOCITY))


func check_modifiers(colour : String):
	reset()
	match colour:
		"Purple":
			gravity_scale = 0.1
		"Orange":
			physics_material_override.set("bounce", 0.5)


func reset():
	gravity_scale = 1
	physics_material_override.set("bounce", 0.1)
