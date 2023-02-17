extends Node2D

var videoclosed = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _physics_process(delta):
	var timeDict = OS.get_time();
	var hour = timeDict.hour;
	var minute = timeDict.minute;
	$Taskbar/Time.text = "%02d:%02d"%[hour,minute]


func _on_StartButton_pressed():
	get_node("PopupMenu").visible = !get_node("PopupMenu").visible


func _on_VideoButton_pressed():
	$Window.visible = !$Window.visible


func _on_Window_popup_hide():
	$Window.visible = false


func _on_TextureButton_pressed():
	$NoAccess.visible = true


func _on_ShutDown_pressed():
	get_tree().quit()
