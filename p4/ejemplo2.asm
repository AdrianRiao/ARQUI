	.data
cad:	.asciiz "Saludos...\n"
	
	
	.text
	
	jal saludo3
	
	
	#--- Terminar
	li $v0, 10
	syscall
	
	
saludo3:
	jal saludo1
	jal saludo1
	jal saludo1
	
	
	jr $ra
	# No podríamos poner esta instrucción ya que el valor de $ra lo utilizan dos subrutinas, por lo que no se
	# actualiza(probar el código y mirar cómo falla). La solución por convenio es guardar las direcciones de retorno en la pila.
	
	# Nota: Contexto = todos los registros que usas en una determinada rutina.
	# En saludo3 tendré 1 contexto  y en saludo1 tendré 3.
	# Deberemos guardar los contextos en la pila(zona de memoria) => Ir a ejemplo3.asm
	
	
saludo1:
	#--- Imprimir mensaje en la consola
	li $v0, 4
	la $a0, cad
	syscall
	
	jr $ra