extends Node2D

var videoclosed = true
onready var tree = get_node("Files/Tree")
var tree_elements = []

onready var handler = get_node("Viewer/ViewportContainer/Viewport/SceneHandler")

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
		$Taskbar/Time.text = "%02d:%02d AM"%[hour,minute]
	else:
		$Taskbar/Time.text = "%02d:%02d PM"%[hour,minute]
	
	for i in range(len(tree_elements)):
		if tree_elements[i] == tree.get_selected():
			$Viewer.visible = true
			putOnTop($Viewer)
			handler.scene = i


func _on_StartButton_pressed():
	get_node("PopupMenu").visible = !get_node("PopupMenu").visible
	


func _on_VideoButton_pressed():
	$Viewer.visible = !$Viewer.visible
	if $Viewer.visible:
		putOnTop($Viewer)


func _on_TextureButton_pressed():
	$NoAccess.visible = true
	putOnTop($NoAccess)


func _on_ShutDown_pressed():
	for i in get_children():
		if i != $Off:
			i.visible = false
	$Off.visible = true
	putOnTop($Off)
	get_tree().quit()


func _on_Data_pressed():
	$Files.visible = true
	putOnTop($Files)

func putOnTop(control):
	var parent = control.get_parent()
	parent.move_child(control, parent.get_child_count())

