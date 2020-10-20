extends Node

export (PackedScene) var Trash
var Score

func _ready():
	randomize()
	
func new_game():
	Score = 0
	$Player.start($StartPosition.position) # load start position for player
	$StartTimer.start()
	$Interface.show_message("Ready?")
	$Interface.update_score(Score)

func game_over(): # Conected to hit signal
	$ScoreTimer.stop()
	$TrashTimer.stop()
	$Interface.game_over()

func _on_StartTimer_timeout():
	$TrashTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	Score += 1
	$Interface.update_score(Score)

func _on_TrashTimer_timeout():
	$TrashPath/TrashPathFollow2D.set_offset(randi()) # Select a random point to create the trash along the path
	var T = Trash.instance()
	add_child(T)
	
	var d = $TrashPath/TrashPathFollow2D.rotation + PI/2 # Select a perpendicular position
	
	T.position = $TrashPath/TrashPathFollow2D.position
	
	#d += rand_range(-PI/4, PI/4)
	#T.rotation  = d
	T.set_linear_velocity(Vector2(rand_range(T.speed_min, T.speed_max),0).rotated(d))
	
