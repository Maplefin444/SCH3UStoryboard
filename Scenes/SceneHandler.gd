extends Node2D

var scene = 0
onready var holder = get_node("SceneHolder")
var scenes = []

func _ready():
	for i in holder.get_children():
		scenes.append(i)

func _physics_process(delta):
	for i in range(len(scenes)):
		if(i == scene): scenes[i].visible = true
		else: scenes[i].visible = false

func _input(event):
	if Input.is_action_just_pressed("ui_right"):
		if scene < len(scenes)-1:
			scene += 1
	if Input.is_action_just_pressed("ui_left"):
		if scene > 0:
			scene -= 1