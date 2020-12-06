extends Control

export var nombre_ennemi = 6
var reset = false
onready var barre_de_vie = $CanvasLayer/BarreDeVie
onready var lvl_progress_bar = $CanvasLayer/ProgressBar
onready var lvl_label = $CanvasLayer/Label
onready var message = $CanvasLayer/Popup/Label
onready var popup = $CanvasLayer/Popup

onready var joueur_node = get_node("/root/"+Global.node_actuel+"/Joueur")

func _ready():
	pass
func _process(delta):
	#update la vie du joueur
	barre_de_vie.value = joueur_node.vie
	lvl_label.text ="Niveau: "+Global.node_actuel[6]
	
	#update le message
	if joueur_node.is_alive ==false:
		message.text = "Vous etre mort"
	elif joueur_node.is_alive == true:
		message.text = "Niveau "+Global.node_actuel[6]+" terminer"
		if Global.node_actuel == "Niveau3":
			reset = true

	niveau_progress()
	if Global.ennemi_tuer == nombre_ennemi:
		popup.show()
	
	if joueur_node.vie <=0:
		popup.show()

func niveau_progress():
	if joueur_node.is_alive:
		lvl_progress_bar.max_value = nombre_ennemi
		lvl_progress_bar.value = Global.ennemi_tuer

func _on_Button_pressed():
		if joueur_node.is_alive:
			#change le niveau
			var next_lvl =  int(int(Global.node_actuel[6])+1)
			Global.node_actuel =  "Niveau"+String(next_lvl)
		if reset == true:
			get_tree().change_scene("res://scenes/Start.tscn")
		if reset == false:
			get_tree().change_scene("res://scenes/Main.tscn")

