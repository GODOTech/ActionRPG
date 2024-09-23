extends Panel 

# This initializes a variable named backgroundSprite of type Sprite2D, and assigns it to the node named 'background' in the scene tree, allowing it to be accessed once the scene is ready.
@onready var backgroundSprite : Sprite2D = $background  
# This initializes a variable named itemSprite of type Sprite2D, and assigns it to the node named 'item' located inside the 'CenterContainer/Panel', making it accessible once the scene is ready.
@onready var itemSprite : Sprite2D = $CenterContainer/Panel/item  

# This defines a function named 'update' that takes a parameter 'item' of type InventoryItem, which will be called to update the UI based on the inventory item passed to it.
func update(item:InventoryItem):  
# This checks if the 'item' parameter is null or not set, indicating there is no item to display.
	if !item:  
		itemSprite.visible = false  
		backgroundSprite.frame = 0  
# If the item is present (not null), the following actions take place.
	else:  
		backgroundSprite.frame = 1  
		itemSprite.visible = true  
		itemSprite.texture = item.texture 
