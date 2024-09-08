extends CharacterBody2D

signal healthChanged

@export var speed: int = 65
@onready var animations = $AnimationPlayer

@export var maxHealth : int = 3
@onready var currentHealth : int = maxHealth

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed

func update_animations():
	if velocity.length() == 0 and animations.is_playing():
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0 : direction = "Left"
		elif velocity.x > 0 : direction = "Right"
		elif velocity.y < 0: direction = "Up"
		elif velocity.y > 0: direction = "Down"
		animations.play("walk" + direction)

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var _collider = collision.get_collider()
		print("I collided with ", collision.get_collider().name)
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	handleCollision()
	update_animations()

func _on_hit_box_area_entered(area):
	if area.name == "HitBox":
		currentHealth -= 1
		#print("I got hit by ", area.get_parent().name ,", life is ", (currentHeath), " HP")
		if currentHealth < 0:
			currentHealth = maxHealth 
		healthChanged.emit(currentHealth)
		
