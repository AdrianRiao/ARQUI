# ¿Cómo pasamos los parámetros a las subrutinas?
# CONVENIO: Los parámetros se pasarán en los registros a0, a1, a2, a3 y en este orden. (si necesito pasar más de 4 parámetros los tendré que pasar por la pila).
# CONVENIO: El valor devuelto por la subrutina debe meterse en el registro v0.


	.text
	
	#-- int mult2 (int n)
	#- Tenemos 1 parámetro y la función devuelve un valor
	
	#--- Convenio:
	#-- Usa v0 para devolver el valor
	#-- El parámetro n lo pasamos por a0
	
	
	#--- Calcular mult2(4)
	
	li $a0, 4
	jal mult2
	
	#--- Imprimir el resultado
	#-- Está en v0
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	#-- Terminar
	li $v0, 10
	syscall
	
mult2:
	# En este caso no necesitamos guardar el contexto, ya que no vamos a llamar a otra subrutina. Si lo necesitáramos
	# hacemos copy-paste, ya que el proceso siempre es el mismo.
	
	li $t0, 2
	mul $v0, $a0, $t0
	
	jr $ra
	
	

