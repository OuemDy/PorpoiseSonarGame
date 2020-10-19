extends RigidBody2D

export(int) var speed_min
export(int) var speed_max
#var trash_type = ["trash"] # for different trash sprites

func _ready():
	
	#AnimatedSprite.animation = trash_type[randi() % trash_type.size()] # randomize type of trash sprites
	#if $AnimatedSprite.animation == "trash": # Change different trash proportions
			#$CollisionShape2D.scale.x = 1.5
			#$CollisionShape2D.scale.y = 1.5 
			
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # delete trash when goes out of the screen
