extends Node2D


func _ready():
	#Change le niveau
	if Global.node_actuel == "Niveau1":
		get_tree().change_scene("res://scenes/Niveau1.tscn")
	if Global.node_actuel == "Niveau2":
		get_tree().change_scene("res://scenes/Niveau2.tscn")
	if Global.node_actuel == "Niveau3":
		get_tree().change_scene("res://scenes/Niveau3.tscn")

