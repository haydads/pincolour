extends Control

var time : float = 0.0
var current_page : int = 1


onready var pages = get_node("%Pages")
onready var previous = get_node("%Previous")
onready var main_menu = get_node("%MainMenu")
onready var next = get_node("%Next")
onready var max_pages : int = get_node("%Pages").get_child_count()


func _ready():
	Global.colour_queue = []
	Global.change_colour()
	previous.connect("pressed", self, "go_to_previous")
	main_menu.connect("pressed", self, "on_main_menu")
	next.connect("pressed", self, "go_to_next")
	check()


func on_main_menu():
	SceneManager.transition_to("MainMenu")


func go_to_previous():
	current_page -= 1
	check()



func go_to_next():
	current_page += 1
	check()


func check():
	previous.disabled = bool(current_page == 1)
	next.disabled = bool(current_page == max_pages)
	
	for page in pages.get_children():
		page.visible = bool(page.name == str(current_page))


func _process(delta : float):
	time += delta
	if time >= 10.0:
		Global.change_colour()
		time = 0.0
