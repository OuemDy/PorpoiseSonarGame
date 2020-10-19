extends Area2D

export(int)var Velocidad
var Movimiento = Vector2()
var limite
#signal catch
signal hit


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # ocultar el personaje
	limite = get_viewport_rect().size # establece limites de la pantalla
	
	
# pass

func _process(delta):
	Movimiento = Vector2() # Reinicia los movimientos
	
	if Input.is_action_pressed("ui_right"): # derecha
		Movimiento.x += 1
	if Input.is_action_pressed("ui_left"): # izquierda
		Movimiento.x -= 1
	if Input.is_action_pressed("ui_up"): # arriba
		Movimiento.y -= 1
	if Input.is_action_pressed("ui_down"): # abajo
		Movimiento.y += 1
	
	if Movimiento.length() > 0: # Verificar si se está moviendo
		Movimiento = Movimiento.normalized() * Velocidad # Normalizar la velocidad
		
	position += Movimiento * delta  # esto estabiliza la velocidad para diferentes computadoras
	position.x = clamp(position.x, 0, limite.x) # impedir que las posiciones superen el limete de la pantalla
	position.y = clamp(position.y, 0, limite.y)
	
	if Movimiento.x != 0:
		$Sprite_player.animation = "swimming" 
		$Sprite_player.flip_h = Movimiento.x <0 # si se mueve a la izquierda voltea el sprite


#func _on_Player_catch(): # capturas
#	emit_signal("catch")
	
#func _on_Player_hit(): # colisiones
#	hide()
#	emit_signal("hit")
#	$CollisionShape2D.disabled = true

func _on_Player_body_entered(body):
	hide() #hide at colission
	emit_signal("hit")
	$CollisionShape2D.disabled = true
	
func inicio(pos):
	position = pos
	show() #show player
	$CollisionShape2D.disabled = false
