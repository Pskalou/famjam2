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


func _physics_process(_delta):	
	var joystick_seuil = 0.5
	var joystick_value = joystick.get_value()

	motion.x = 0
	motion.y = 0

	if Input.is_action_pressed("ui_right") or joystick_value.x > joystick_seuil:
		$AnimatedSprite.flip_h = false
		motion.x = SPEED	
	if Input.is_action_pressed("ui_left") or joystick_value.x < -joystick_seuil:
		$AnimatedSprite.flip_h = true
		motion.x = -SPEED
	if Input.is_action_pressed("ui_up") or joystick_value.y < -joystick_seuil:
		motion.y = -SPEED
	if Input.is_action_pressed("ui_down") or joystick_value.y > joystick_seuil:
		motion.y = SPEED

	if motion == Vector2(0,0):
		$AnimatedSprite.play("idle")
		audio_pas.stream_paused = true
	else:
		$AnimatedSprite.play("walk")
		audio_pas.stream_paused = false
		var _ignore = move_and_slide(motion, FLOOR_NORMAL)
		
