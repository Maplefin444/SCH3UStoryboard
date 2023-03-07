extends Node2D

var videoclosed = true
onready var tree = get_node("GUI/Files/Tree")
onready var viewer = get_node("GUI/Viewer")
onready var off = get_node("GUI/Off")
onready var noaccess = get_node("GUI/Access")
onready var menu = get_node("GUI/PopupMenu")
onready var files = get_node("GUI/Files")
var selected
var tree_elements = []

onready var handler = get_node("GUI/Viewer/ViewportContainer/Viewport/SceneHandler")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	var root = tree.create_item()
	root.set_text(0,"Storyboard Data")
	for i in handler.get_node("SceneHolder").get_children():
		var _item = tree.create_item(root)
		_item.set_text(0,i.name)
		tree_elements.append(_item)

func _physics_process(delta):
	var timeDict = OS.get_time();
	var hour = timeDict.hour;
	var pm = false
	if hour > 12:
		hour -= 12
		pm = true
	var minute = timeDict.minute;
	if !pm:
		$GUI/Taskbar/Time.text = "%02d:%02d AM"%[hour,minute]
	else:
		$GUI/Taskbar/Time.text = "%02d:%02d PM"%[hour,minute]
	
	for i in range(len(tree_elements)):
		if tree_elements[i] == tree.get_selected():
			if selected != tree.get_selected():
				selected = tree.get_selected()
				putOnTop($GUI/Viewer)
				$GUI/Viewer.visible = true
				handler.scene = i


func _on_StartButton_pressed():
	if !menu.visible:
		putOnTop(menu)
		menu.visible = true
	else:
		menu.visible = false


func _on_VideoButton_pressed():
	if !viewer.visible:
		putOnTop(viewer)
		viewer.visible = true
	else:
		viewer.visible = false



func _on_TextureButton_pressed():
	putOnTop(noaccess)
	noaccess.visible = true


func _on_ShutDown_pressed():
	for i in $GUI.get_children():
		if i != off:
			i.visible = false
	off.visible = true
	putOnTop(off)
	get_tree().quit()


func _on_Data_pressed():
	putOnTop(files)
	files.visible = true
	

func putOnTop(control):
	var parent = control.get_parent()
	parent.move_child(control, parent.get_child_count())






func _on_Recycle_Bin_pressed():
	$CanvasLayer/ScanLines.visible = !$CanvasLayer/ScanLines.visible
