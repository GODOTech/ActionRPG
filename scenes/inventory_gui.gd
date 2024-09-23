extends Control  # This line indicates that the script extends the Control class, which is a base class for all UI controls in Godot.

# This defines a signal that can be emitted to notify other parts of the code that the inventory has been opened or closed.
signal opened  
signal closed  

var isOpen: bool = false  

# This initializes a variable named inventory of type Inventory, and preloads the inventory resource from the specified path, making it available once the scene is ready.
@onready var inventory : Inventory = preload("res://inventory/player_inventory.tres")  
# This initializes a variable named slots as an Array, containing all children nodes of the GridContainer located inside NinePatchRect, UI elements representing inventory slots.
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()  

func _ready():
	update()  

# This defines a function named 'update' to refresh the inventory slots with the items from the inventory.
func update():  
# Loops through the range of the smaller size between the inventory items array and the slots array to avoid index out-of-bounds errors.
	for i in range(min(inventory.items.size(), slots.size())):  
# Calls the update method on each slot, passing the corresponding inventory item to update the visual representation of that slot.
		slots[i].update(inventory.items[i])  

func open():  
	visible = true  
	isOpen = true  
# Emits the 'opened' signal to notify any listeners that the inventory has been opened. In this case main.gd
	opened.emit()  

func close():  
	visible = false  
	isOpen = false  
# Emits the 'closed' signal to notify any listeners that the inventory has been closed. In this case main.gd
	closed.emit()  
