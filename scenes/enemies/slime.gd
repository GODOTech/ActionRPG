class_name  enemy
extends CharacterBody2D
@export var speed = 15
@export var limit = 0.5
@export var endPoint: Marker2D
@onready var animations = $AnimationPlayer

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * speed

func update_animations():
	if velocity.length() == 0 and animations.is_playing():
		animations.stop()
	else:
		var direction = "Down"
		if velocity.y > 0: direction = "Down"
		elif velocity.y < 0: direction = "Up"
		elif velocity.x < 0 : direction = "Left"
		elif velocity.x > 0 : direction = "Right"
		animations.play("Walk" + direction)

func _physics_process(_delta):
	updateVelocity()
	move_and_slide()
	update_animations()
