extends Node


signal update_score()
signal update_balls()
signal update_multiplier()
signal update_colour()


signal activate_modifier(colour)


var score = 0 setget update_score
var balls_left = 3 setget update_balls
var multiplier : float = 1.0 setget update_multiplier
var bonus_multiplier : float = 1.0
var colour : Color #= Color(0, 0.5, 1, 1)
var colour_name : String = ""
var save_timer : float = 0.0
var game_over : bool = false

var colours : Array = ["Yellow", "Orange", "Red", "Green", "Blue", "Magenta", "Cyan"]
var colour_queue : Array = ["White"]


func update_score(new_score : int):
	score = new_score
	if game_over: return
	emit_signal("update_score")


func update_balls(new_amount : int):
	balls_left = new_amount
	if game_over: return
	emit_signal("update_balls")


func update_multiplier(new_multiplier : float):
	multiplier = new_multiplier
	if game_over: return
	emit_signal("update_multiplier")


func change_colour():
	if game_over: return
	if colour_queue.empty():
		colour_queue.append_array(colours)
		randomize()
		colour_queue.shuffle()
	
	if colour_name == "Yellow":
		multiplier /= 2
		emit_signal("update_multiplier")
		
	
	colour_name = colour_queue.pop_back()
	match colour_name:
		"Yellow":
			colour = Color(1, 1, 0, 1)
			multiplier *= 2
			emit_signal("update_multiplier")
		"Orange":
			colour = Color(1, 0.7, 0.2, 1)
		"Red":
			colour = Color(1, 0.2, 0.2, 1)
		"Green":
			colour = Color(0, 1, 0.2, 1)
		"Blue":
			colour = Color(0, 0.5, 1, 1)
		"Magenta":
			colour = Color(1, 0.2, 1, 1)
		"White":
			colour = Color(0.5, 0.5, 0.5, 1)
		"Cyan":
			colour = Color(0, 1, 1, 1)
			
	emit_signal("update_colour")
	emit_signal("activate_modifier", colour_name)
