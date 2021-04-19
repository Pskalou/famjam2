# déplacement du personnage KidPaddle dans la salle d'arcade
extends KinematicBody2D


onready var audio_pas:AudioStreamPlayer2D = $Audio_pas_01
onready var joystick= get_parent().get_node("Joystick/Joystick_button")

# vitesse de déplacement
const SPEED = 200
# Orientation de la scene vers le haut
const FLOOR_NORMAL = Vector2(0, -1)
# direction de déplacement du personnage
var motion =Vector2()


func _ready():
	# bruits de pas : préchargement, mise en pause
	audio_pas.playing = true
	audio_pas.stream_paused = true



func droite():
	audio_pas.stream_paused = false
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.play("walk")
	motion.x = SPEED

func gauche():
	audio_pas.stream_paused = false
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("walk")
	motion.x = -SPEED
func haut():
	audio_pas.stream_paused = false
	$AnimatedSprite.play("walk")
	motion.y = -SPEED

func bas():
	audio_pas.stream_paused = false
	$AnimatedSprite.play("walk")
	motion.y = SPEED	
func arret():
	audio_pas.stream_paused = true
	motion.x = 0
	motion.y = 0
	$AnimatedSprite.play("idle")
	
func _physics_process(_delta):	
	var joystick_seuil = 0.7
	var joystick_value = joystick.get_value()

	if Input.is_action_pressed("ui_right"):
		droite()
	elif Input.is_action_pressed("ui_left"):
		gauche()
	elif Input.is_action_pressed("ui_up"):
		haut()
	elif Input.is_action_pressed("ui_down"):
		bas()
	elif joystick_value.length() > 0:
		if joystick_value.x > joystick_seuil:
			droite()
		if joystick_value.x < -joystick_seuil:
			gauche()
		if joystick_value.y < -joystick_seuil:
			haut()
		if joystick_value.y > joystick_seuil:
			bas()
	else:
		arret()
	
	var _ignore = move_and_slide(motion, FLOOR_NORMAL)
		
