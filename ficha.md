# Ficha del Dispositivo: Teclado

**Estudiante:** Mateo Llumigusin  
**NRC:** 36870  
**Materia:** Videojuegos  

---

* **Tecnología de captura:**
  * **Funcionamiento interno:** Utiliza una matriz de circuitos eléctricos distribuida bajo cada tecla. Al presionar una tecla (ya sea mediante un mecanismo de membrana elastomérica o un interruptor mecánico individual), se cierra un contacto físico completando el circuito.
  * **Procesamiento de la señal:** El microcontrolador integrado en el teclado realiza un escaneo periódico de la matriz (polling). Al detectar el contacto, genera una interrupción de hardware y transmite un código de escaneo (*scancode* de activación `Make` y de liberación `Break`) hacia el sistema operativo. En motores de videojuegos como Godot, este flujo es interpretado y encapsulado como un objeto `InputEventKey`.

* **Tipo de señal: Digital (Discreta / Binaria)**
  * **Justificación técnica:** Cada tecla opera exclusivamente bajo dos estados lógicos: **`0` (Inactivo / Abierto)** cuando está en reposo y **`1` (Activo / Cerrado)** cuando está pulsada. No existe graduación física de profundidad, presión o inclinación en un teclado estándar. Por ende, en el motor de juego las lecturas no devuelven valores continuos o flotantes intermedios; métodos como `Input.is_action_pressed()` retornan directamente un booleano (`true` o `false`), y `Input.get_action_strength()` entrega valores discretos (`0.0` o `1.0`).

* **Ventajas en el diseño de videojuegos:**
  * **Latencia mínima y respuesta inmediata:** Al ser un pulso binario directo, el tiempo de activación es prácticamente instantáneo, eliminando la necesidad de zonas muertas (*deadzones*) requeridas en sensores analógicos.
  * **Amplio repertorio de entradas simultáneas (Keybinds):** Cuenta con más de 100 teclas individuales que permiten mapear una inmensa cantidad de acciones, habilidades, atajos rápidos y accesos a menús sin necesidad de combinaciones complejas.
  * **Consistencia y predictibilidad:** Cada pulsación produce siempre el mismo resultado uniforme, facilitando la memoria muscular en mecánicas que demandan precisión temporal milimétrica.

* **Limitaciones técnicas y de jugabilidad:**
  * **Ausencia de control analógico de velocidad y trayectoria:** El jugador no puede regular de manera progresiva la velocidad de desplazamiento ni girar con ángulos suaves únicamente con el teclado; el personaje pasa de velocidad cero al 100% de aceleración instantáneamente.
  * **Problemas de *Ghosting* y *Key Rollover*:** En teclados convencionales de oficina (membrana), la matriz puede bloquearse o registrar pulsaciones fantasma al presionar más de 3 o 4 teclas concurrentes, requiriendo teclados especializados con *N-Key Rollover* (NKRO) para juego competitivo.

* **Juego ejemplo:** ***Counter-Strike 2* (o *Valorant*)**
  * **Aprovechamiento de la señal digital:** Los shooters tácticos aprovechan la naturaleza binaria de las teclas `W`, `A`, `S`, `D` para mecánicas de alto rendimiento como el ***Counter-Strafing***: al soltar la tecla de movimiento o tocar rápidamente la tecla contraria, el personaje frena en seco de forma inmediata, lo cual restablece al 100% la precisión del disparo en milisegundos.
  * **Cómo mitiga la limitación analógica:** Dado que el teclado no permite regular la velocidad gradualmente como un joystick, el juego implementa una tecla modificadora digital secundaria (usualmente `Shift`) para alternar discretamente entre el estado de velocidad máxima (*correr*) y una velocidad fija reducida (*caminar sigilosamente*).

* **Referencias:**
  * [Godot Engine Documentation - Class: InputEventKey](https://docs.godotengine.org/en/stable/classes/class_inputeventkey.html)
  * [Godot Engine Documentation - Input examples & Input Map](https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html)