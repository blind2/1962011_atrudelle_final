extends Node2D

func _ready():
	Global.node_actuel = "Niveau1"
func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
