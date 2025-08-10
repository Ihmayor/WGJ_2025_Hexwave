class_name ItemStats extends Resource
enum ItemLocation{
	Hat,
	Shirt,
	Bottom
}

@export var business_stat: int
@export var glamour_stat: int
@export var edgy_stat: int
@export var item_location:ItemLocation
