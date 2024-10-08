extends CharacterBody2D

signal healthChanged # nombre de la señal a emitir

@export var speed: int = 65
@onready var animations = $AnimationPlayer
@onready var collisionTimer = $CollisionShape2D/collisionTimer

@export var maxHealth : int = 3
@onready var currentHealth : int = maxHealth
@onready var hitBox = $HitBox

@export var knockBackPower : int = 600
@onready var effects = $Effects
@onready var hurtTimer = $hurtTimer
@onready var weapon = $weapon

@export var inventory = Inventory
 
var lastAnimDirection: String = "Down"
var isHurt : bool = false
var isAttacking: bool = false 

func _ready():
	effects.play("RESET")
	weapon.visible = false

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
	if Input.is_action_pressed("attack"):
		attack()

func attack():
	animations.play("attack" + lastAnimDirection)
	isAttacking = true
	weapon.enable()
	await animations.animation_finished
	weapon.disable()
	isAttacking = false
	

func update_animations():
	if isAttacking : return
	if velocity.length() == 0 and animations.is_playing():
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0 : direction = "Left"
		elif velocity.x > 0 : direction = "Right"
		elif velocity.y < 0: direction = "Up"
		elif velocity.y > 0: direction = "Down"
		animations.play("walk" + direction)
		lastAnimDirection = direction

func handleCollision() -> void:
	var slide_collision_count = get_slide_collision_count()
	if slide_collision_count > 0:# Check if there are any collisions detected
		for i in range(slide_collision_count):# Iterate through the number of collisions detected
			var collision = get_slide_collision(i)
			if collision != null:# Check if the collision is valid before accessing it
				var _collider = collision.get_collider()
				print("I collided with ", _collider.name)
				collisionTimer.start()
				await collisionTimer.timeout
			else:
				print("Collision at index ", i, " is null.")

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth 
	healthChanged.emit(currentHealth) # emitir señal de que la salud cambio
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hit_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
	##if isHurt: return # si esta en estado dañado vuelve sin hacer nada
	#if area.name == "HitBox":
		#enemyCollitions.append(area)

func knockback(enemyVelocity:Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockBackPower 
	velocity = knockbackDirection
	print("-------¡HIT!-------")
	#print("Velocity: ", int(velocity.length()))  
	print("Start: X", int(position.x), ", Y", int(position.y))
	move_and_slide()
	print("Finish: X", int(position.x), ", Y", int(position.y))
	print("")

func _on_hit_box_area_exited(_area):pass
	#enemyCollitions.erase(area)

func _physics_process(_delta):
	handleInput()
	move_and_slide()
	update_animations()
	checkHurt()
	#handleCollision()
	
	
	
func checkHurt():
	if !isHurt:
		for area in hitBox.get_overlapping_areas(): #le pone el nombre de enemyArea a todos los elementos del array
			if area.name =="hitBox":
				hurtByEnemy(area)
