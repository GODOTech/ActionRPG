extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer # el contenedor de corazones es este hijo
@onready var player = $player

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth) # mandarle esta funcion funcion de este hijo: esta variable de este hijo 
	heartsContainer.updateHearts(player.currentHealth) # actualizar los corazones con la salud del personaje
	player.healthChanged.connect(heartsContainer.updateHearts) # conectar la señal salud cambio, con actualizar corazones
