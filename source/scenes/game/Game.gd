extends Node

const STOPPER = preload("res://scenes/table/stopper/Stopper.tscn")
const BALL = preload("res://scenes/table/ball/Ball.tscn")

onready var balls : Node2D = get_node("%Balls")
onready var boundary : Area2D = get_node("%Boundary")
onready var stoppers : Node2D = get_node("%Stoppers")
onready var bonus : Node2D = get_node("%Bonus")
onready var bonus_gate : Node2D = get_node("%BonusGate")
onready var scoreboard : Control = get_node("%Scoreboard")


func _ready():
	Global.connect("activate_modifier", self, "check_modifiers") # warning-ignore:return_value_discarded
	boundary.connect("body_entered", self, "lost_ball") # warning-ignore:return_value_discarded
	bonus.connect("body_entered", self, "bonus_zone") # warning-ignore:return_value_discarded
	
	for button in get_tree().get_nodes_in_group("Actions"):
		button.connect("pressed", self, "on_button_pressed", [button.get_name()])
	
	reset()


func on_button_pressed(_button):
	match _button:
		"Retry": 
			SceneManager.transition_to("Game")
			reset()
		"MainMenu":
			SceneManager.transition_to("MainMenu")


func create_ball():
	var ball = BALL.instance()
	balls.add_child(ball)
	ball.position = Vector2(810, 660)
	Global.balls_left -= 1


func lost_ball(ball):
	ball.queue_free()
	get_node("%LostBall").play()
	yield(get_tree(), "idle_frame")
	if balls.get_child_count() <= 0:
		scoreboard.set_banner("LostBall")
		#Global.multiplier = 1.0
		#if Global.colour_name == "Yellow": Global.multiplier = 2.0
		if Global.balls_left > 0:
			var yield_time : float = 2.0
			if Global.colour_name == "Magenta": yield_time = 1.0
			yield(get_tree().create_timer(yield_time), "timeout")
			create_ball()
		else:
			scoreboard.set_banner("GameOver")
			Global.game_over = true
			get_node("%Description").text = "You scored\n%s\nPoints!" % Global.score
			get_node("%GameOver").popup()



func check_modifiers(colour : String):
	Engine.time_scale = 1.0
	for child in stoppers.get_children(): child.queue_free() # Remove any stoppers
	bonus.position = Vector2(0, -1000)
	bonus_gate.position = Vector2(420, 105)
	
	match colour:
		"Blue":
			var stopper = STOPPER.instance()
			stoppers.add_child(stopper)
			stopper.position = Vector2(420, 815)
			stopper.modulate = Global.colour
		"Magenta":
			Engine.time_scale = 0.5
		"Green":
			bonus.position = Vector2(420, 65)
			bonus_gate.position = Vector2(0, -1000)
		"Cyan":
			bonus.position = Vector2(420, 65)
			bonus_gate.position = Vector2(0, -1000)


func bonus_zone(ball):
	ball.queue_free()
	bonus.position = Vector2(0, -1000)
	bonus_gate.position = Vector2(420, 105)
	yield(get_tree(), "idle_frame")
	
	match Global.colour_name:
		"Green":
			scoreboard.set_banner("MultiBall")
			
			yield(get_tree().create_timer(1.0), "timeout")
			
			ball = BALL.instance()
			balls.add_child(ball)
			ball.position = Vector2(780, 60)
			
			yield(get_tree().create_timer(1.0), "timeout")
			
			ball = BALL.instance()
			balls.add_child(ball)
			ball.position = Vector2(780, 60)
			
		"Cyan":
			scoreboard.set_banner("ExtraBall")
			
			yield(get_tree().create_timer(1.0), "timeout")
			
			ball = BALL.instance()
			balls.add_child(ball)
			ball.position = Vector2(780, 60)
			
			Global.balls_left += 1


func reset():
	Global.balls_left = 3
	Global.score = 0
	Global.multiplier = 1.0
	if Global.colour_name == "Yellow": Global.multiplier = 2.0
	Global.game_over = false
	Global.colour_queue = ["White"]
	Global.change_colour()
	create_ball()
