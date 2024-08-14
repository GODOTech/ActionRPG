extends CharacterBody2D

@export var speed: int = 65
@onready var animations = $AnimationPlayer
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
		var collider = collision.get_collider()
		print_debug(collider.name)
	#var collision = move_and_collide(velocity * delta)
	#print("I collided with ", collision.get_collider().name)
func _physics_process(_delta):
	handleInput()
	move_and_slide()
	handleCollision()
	update_animations()
	

