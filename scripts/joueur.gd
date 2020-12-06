extends KinematicBody2D

export var speed = 200
export var dempening = 0.90
var is_alive = true
var velocity = Vector2()
onready var canon = $JoueurSprite/Canon
onready var sprite = $JoueurSprite

var vie = 100

export(PackedScene) var balle = preload("res://scenes/Balle.tscn")

func _ready():
	is_alive = true
	Global.ennemi_tuer =0

func _physics_process(delta):
	get_input()
	prendre_degat(delta)
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 5:
		#On fait une rotation du sprite et de la position2D au lieu du root
		#pour empecher au GameUI d'hérité de la rotation
		sprite.rotation = dir.angle()
		sprite.rotation_degrees -= -90
		canon.rotation = dir.angle()
	
	if vie <=0:
		is_alive  = false

func prendre_degat(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		if "Missile" in collision.collider.name:
			#10%
			vie-=10
			collision.collider.queue_free()
			print(String(vie))
		if "BalleEnnemi" in collision.collider.name:
			#5%
			vie-=5
			collision.collider.queue_free()
			print(String(vie))


func get_input():
	var shoot = Input.is_action_just_pressed("mouse_right_click")
	var avancer = Input.is_action_pressed("key_W")
	var reculer = Input.is_action_pressed("key_S")
	var droite = Input.is_action_pressed("key_D")
	var gauche = Input.is_action_pressed("key_A")

	if avancer:
		velocity = Vector2(0, -speed)
	if reculer:
		velocity = Vector2(0, speed)
	if droite:
		velocity = Vector2(speed,0)
	if gauche:
		velocity = Vector2(-speed,0)
	if shoot:
		var balle_instance = balle.instance()	
		balle_instance._creer(canon.global_position,canon.rotation)
		get_parent().add_child(balle_instance)
	else:
		#ralenti le joueur
		velocity*= dempening
