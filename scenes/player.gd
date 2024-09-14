extends CharacterBody2D

signal healthChanged # nombre de la señal a emitir

@export var speed: int = 65
@onready var animations = $AnimationPlayer

@export var maxHealth : int = 3
@onready var currentHealth : int = maxHealth

@export var knockBackPower : int = 600
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

func handleCollision() -> void:
	var slide_collision_count = get_slide_collision_count()
	if slide_collision_count > 0:# Check if there are any collisions detected
		for i in range(slide_collision_count):# Iterate through the number of collisions detected
			var collision = get_slide_collision(i)
			if collision != null:# Check if the collision is valid before accessing it
				var _collider = collision.get_collider()
				print("I collided with ", _collider.name)
				await get_tree().create_timer(1.0,1,0,1).timeout
			else:
				print("Collision at index ", i, " is null.")

func _on_hit_box_area_entered(area):
	if area.name == "HitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth 
		healthChanged.emit(currentHealth) # emitir señal de que la salud cambio
		
		
		knockback(area.get_parent().velocity) #HAhAhahaAHAHAHAHAHAHahhahaha

func knockback(enemyVelocity:Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockBackPower 
	velocity = knockbackDirection
	print("-------¡HIT!-------")
	print("Velocity: ", int(velocity.length()))  
	print("Start: X", int(position.x), ", Y", int(position.y))
	move_and_slide()
	print("Finish: X", int(position.x), ", Y", int(position.y))
	print("")

func _physics_process(_delta):
	handleInput()
	move_and_slide()
	#handleCollision()
	update_animations()
