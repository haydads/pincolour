extends Node2D



export var multiplier : float = 1.0

onready var lights : Array = get_children()



func _process(_delta : float):
	if Input.is_action_just_pressed("both_flippers"):
		
		#lights.invert()
		var active_array : Array = []
		for light in lights:
			if light.active:
				active_array.append(int(light.name) + 1)
				light.active = false
				light.activate()
		
		for light in active_array:
			if light >= lights.size():
				active_array.append(0)
		print(active_array)
		
		for light in lights:
			if active_array.has(int(light.name)):
				light.active = true
				light.activate()
		
		if active_array.size() >= lights.size():
			check()


func check():
	for light in lights:
		if not light.active: return
	
	
	Global.multiplier += multiplier
	if Global.colour_name == "Yellow": Global.multiplier += multiplier
	
	for light in lights:
		light.active = false
		light.activate()
