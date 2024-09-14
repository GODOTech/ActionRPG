extends Panel

@onready var sprite = $Sprite2D  # para que "sprite" sea el nombre del "corazon"

func update(whole: bool): # actualiza el estado del corazon de lleno a vacio
	if whole: sprite.frame = 3
	else: sprite.frame = 0


