extends Node2D

@onready var label: Label = $Label

var cuadro_pulsado := 0
var eventos_recibidos := 0

# Variables para registrar el último evento (Requisito R3)
var ultimo_evento_clase := "Ninguno"
var dispositivo_actual := "Ninguno"
var tipo_senal := "N/A"

func _physics_process(delta: float) -> void:
	# R4: Contar cuadros (frames) en los que la acción está pulsada
	if Input.is_action_pressed("move_right"):
		cuadro_pulsado += 1
	
	# R2: Lectura de estado, eje y fuerza con 2 decimales
	var jump_activo = Input.is_action_pressed("jump")
	var axis_val = Input.get_axis("move_left", "move_right")
	var strength_val = Input.get_action_strength("move_right")
	
	# Actualizar texto del HUD en tiempo real
	label.text = "=== PANEL DE CONTROL (HUD) ===" \
		+ "\n[R4] Cuadros pulsados (move_right): %d" % cuadro_pulsado \
		+ "\n[R4] Eventos recibidos (move_right): %d" % eventos_recibidos \
		+ "\n--------------------------------------------------" \
		+ "\n[R2] Jump (activo): %s" % str(jump_activo) \
		+ "\n[R2] get_axis ('move_left', 'move_right'): %.2f" % axis_val \
		+ "\n[R2] get_action_strength ('move_right'): %.2f" % strength_val \
		+ "\n--------------------------------------------------" \
		+ "\n[R3] Última clase de evento: %s" % ultimo_evento_clase \
		+ "\n[R3] Dispositivo detectado: %s" % dispositivo_actual \
		+ "\n[R3] Tipo de señal: %s" % tipo_senal

func _input(event: InputEvent) -> void:
	# R3: Ignorar el eco automático del teclado al mantener presionada una tecla
	if event is InputEventKey and event.is_echo():
		return
		
	# R3: Registrar clase de evento y tipo de dispositivo
	ultimo_evento_clase = event.get_class()
	
	if event is InputEventKey:
		dispositivo_actual = "Teclado"
		tipo_senal = "Digital"
	elif event is InputEventMouseButton:
		dispositivo_actual = "Ratón"
		if event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]:
			tipo_senal = "Digital (Rueda de desplazamiento)"
		else:
			tipo_senal = "Digital (Clic de botón)"
	elif event is InputEventMouseMotion:
		dispositivo_actual = "Ratón"
		tipo_senal = "Posición / Analógica relativa"
	elif event is InputEventJoypadButton:
		dispositivo_actual = "Mando / Gamepad"
		tipo_senal = "Digital"
	elif event is InputEventJoypadMotion:
		dispositivo_actual = "Mando / Gamepad"
		tipo_senal = "Analógica"

	# R4: Contar eventos reales de entrada para move_right
	if event.is_action("move_right"):
		eventos_recibidos += 1
