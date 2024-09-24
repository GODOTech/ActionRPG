extends "res://scenes/Collectable.gd"

@onready var animation = $AnimationPlayer
@onready var player = get_tree().get_root().get_node("main/player") # Adjust path based on your scene hierarchy

var is_collecting = false

func collect(inventory:Inventory):
	if is_collecting:return  # Prevent further collection if already collecting
	is_collecting = true
	animation.play("pickup")
	await animation.animation_finished
	is_collecting = false
	super(inventory)  # Call collect in the base script
	#queue_free()  # Remove this collectible from the scene after collecting

func _process(delta):
	if is_collecting:
		# Follow the player during the animation
		position = position.lerp(player.position, 30 * delta) # Adjust speed as needed
