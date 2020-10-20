extends Area2D

export(int)var Speed
var Movement = Vector2()
var limit
#signal catch
signal hit

func _ready():
	hide() # ocultar el personaje
	limit = get_viewport_rect().size # establece limites de la pantalla

func _process(delta):
	Movement = Vector2() # Reinicia los movimientos
	
	if Input.is_action_pressed("ui_right"): # derecha
		Movement.x += 1
	if Input.is_action_pressed("ui_left"): # izquierda
		Movement.x -= 1
	if Input.is_action_pressed("ui_up"): # arriba
		Movement.y -= 1
	if Input.is_action_pressed("ui_down"): # abajo
		Movement.y += 1
	
	if Movement.length() > 0: # Verificar si se está moviendo
		Movement = Movement.normalized() * Speed # Normalizar la velocidad
		
	position += Movement * delta  # esto estabiliza la velocidad para diferentes computadoras
	position.x = clamp(position.x, 0, limit.x) # impedir que las posiciones superen el limete de la pantalla
	position.y = clamp(position.y, 0, limit.y)
	
	if Movement.x != 0:
		$Sprite_player.animation = "swimming" 
		$Sprite_player.flip_h = Movement.x <0 # si se mueve a la izquierda voltea el sprite


#func _on_Player_catch(): # capturas
#	emit_signal("catch")
	

func _on_Player_body_entered(body):
	hide() #hide at colission
	emit_signal("hit")
	$CollisionShape2D.disabled = true
	
func start(pos):
	position = pos
	show() #show player
	$CollisionShape2D.disabled = false
