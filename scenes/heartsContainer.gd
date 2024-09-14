extends HBoxContainer

@onready var HeartGuiClass = preload("res://scenes/heartGui.tscn") #declara el corazon como la clase

func setMaxHearts(maxhearts: int): # la cantidad maxima de corazones, un numero entero
	for i in range(maxhearts): # cada iteracion, cantidad de veces : maximo de corazones
		var heart = HeartGuiClass.instantiate() # corazon es la clase corazon
		add_child(heart)# simplemete lo añade y como es un contenedor lo ordena segun sus propiedades

func updateHearts(currentHealth: int):
	var hearts = get_children() # corazones: los niños de este nodo contenedor
	
	for i in range(currentHealth): # la salud acctual esta en el script del jugador
		hearts[i].update(true) # pone en true la cantidad de corazones que representan la salud actual
	
	for i in range(currentHealth, hearts.size()): # de salud actual, a salud total, ergo: corazones vacios. starting from currentHealth to the total number of hearts
		hearts[i].update(false) # setear los corazone en el rango
