extends KinematicBody2D

export var speed = 50
onready var canon = $Canon
onready var shoot_delay = $Delay
onready var zone = $Zone
var velocity = Vector2()
var vie = 150
var peut_bouger = false
onready var joueur_node = get_node("/root/"+Global.node_actuel+"/Joueur")

export(PackedScene) var missile = preload("res://scenes/Missile.tscn")

func _ready():
	shoot_delay.set_wait_time(1.2)
	shoot_delay.start()

func _physics_process(delta):
	follow()
	var collision = move_and_collide(velocity*delta)
	if collision:
		if "Balle" in collision.collider.name:
			call_deferred('free')
			Global.ennemi_tuer+=1

func shoot():
	var missile_instance = missile.instance()	
	missile_instance.rotation =rotation
	missile_instance._creer(canon.global_position,rotation)
	get_parent().add_child(missile_instance)

func follow():
	if peut_bouger:
		var dirrection = joueur_node.position-position
		rotation = dirrection.angle()
		velocity = Vector2(speed,0).rotated(rotation)
	

func _on_Delay_timeout():
	if peut_bouger:
		shoot()
	

func _on_Zone_body_entered(body):
	if "Joueur" in body.name:
		peut_bouger = true
