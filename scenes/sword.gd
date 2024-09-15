extends "res://scenes/Collectable.gd"

@onready var animation = $AnimationPlayer
#func collect():
	#animation.play("pickup")
	#await animation.animation_finished
	#super() # llama a collect en el script base




@onready var player = get_tree().get_root().get_node("main/player") # Adjust path based on your scene hierarchy
var is_collecting = false

func collect():
	is_collecting = true
	animation.play("pickup")
	await animation.animation_finished
	is_collecting = false
	super() # Call collect in the base script

func _process(delta):
	if is_collecting:
		# Follow the player during the animation
		position = position.lerp(player.position, 30 * delta) # Adjust speed as needed
