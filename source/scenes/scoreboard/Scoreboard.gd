extends Control


onready var score : Label = get_node("%Score")
onready var banner : Label = get_node("%Banner")
onready var background : ColorRect = get_node("%ColorRect")
onready var game_over : bool = false


func _ready():
	Global.connect("activate_modifier", self, "set_banner") # warning-ignore:return_value_discarded
	Global.connect("update_colour", self, "update_colour") # warning-ignore:return_value_discarded
	Global.connect("update_score", self, "update_score") # warning-ignore:return_value_discarded


func update_score():
	score.text = "SCORE: " + str(Global.score)


func update_colour():
	background.color = Global.colour


func set_banner(message : String):
	if Global.game_over: return
	score.visible = false
	banner.visible = true
	var yield_time = 2.0
	
	
	match message:
		"Yellow":
			banner.text = "2x Scoring Activated"
		"Orange":
			banner.text = "Bouncy Ball Activated"
		"Red":
			banner.text = "Mono Flippers Activated"
		"Green":
			banner.text = "Extra Ball Available"
		"Blue":
			banner.text = "Stopper Activated"
		"Magenta":
			banner.text = "Slow Motion Activated"
			yield_time = 1.0
		"Cyan":
			banner.text = "Extra Ball Available"
		"White":
			banner.text = "New Game Started"
		"LostBall":
			banner.text = "Ball Lost!"
			if Global.balls_left > 0:
				yield(get_tree().create_timer(2.0), "timeout")
				set_banner("BallsRemaining")
			
		"GameOver":
			banner.text = "Game Over"
			game_over = true
		"MultiBall":
			banner.text = "MultiBall Activated"
		"ExtraBall":
			banner.text = "Extra Ball Added!"
		"BallSaved":
			banner.text = "Ball Saved!"
		"BallsRemaining":
			if Global.balls_left == 1: banner.text = "LAST BALL!"
			else: banner.text = str(Global.balls_left) + " Balls Remaining"
	
	if game_over: return
	
	yield(get_tree().create_timer(yield_time), "timeout")
	score.visible = true
	banner.visible = false
