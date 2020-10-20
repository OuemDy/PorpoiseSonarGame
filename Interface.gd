extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$PlayButton.show()
	$Message.text = "A Porpoise's Purpose"
	$Message.show()

func update_score(Score):
	$ScoreLabel.text = str(Score)

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_PlayButton_pressed():
	$PlayButton.hide()
	emit_signal("start_game")
