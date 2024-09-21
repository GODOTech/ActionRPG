class_name Enemy
extends CharacterBody2D

@export var speed = 15
@export var limit = 0.5
@onready var animations = $AnimationPlayer

var startPosition
var endPosition
var endPoint: Marker2D  # Declare the variable without export

func _ready():
	# Initialize endPoint by finding the first child of type Marker2D
	for child in get_children():
		if child is Marker2D:
			endPoint = child
			break  # Exit the loop after finding the first Marker2D

	if endPoint:
		startPosition = position
		endPosition = endPoint.global_position
	else:
		print("No Marker2D found in the enemy instance!")

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

