	.data
cad:	.asciiz "Saludos...\n"
	
	
	.text
	
	jal saludo3
	
	
	#--- Terminar
	li $v0, 10
	syscall
	
	
saludo3:
	#--- Guardar el contexto en la pila
	#--- Crear el marco de pila (siempre lo dejaremos de 32 bytes, por lo que nos cabrán 8 palabras) 
	#--- Nota: los marcos de pila deben ser múltiplos de 32.
	subu $sp, $sp, 32 #Restamos 32 bytes ya que la pila crece hacia abajo (menores dir. de memoria)
	
	#--- Guardamos la dirección de retorno (lo puedes guardar en la palabra que quieras, en este caso la guardaremos
	#--- en la palabra número 5, es decir, el byte 20.
	sw $ra, 20($sp)
	
	#--- Guardamos el puntero del marco de pila (igual que antes, donde tú quieras)
	sw $fp, 16($sp)
	
	#--- Situar el puntero del marco de pila (fp) en la cima
	addiu $fp, $sp, 28
	
	jal saludo1
	jal saludo1
	jal saludo1
	
	#--- Recuperar el contexto de la pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32 #Le sumamos 32 para dejarlo como estaba antes
	
	
	
	jr $ra
	
saludo1:
	#--- Imprimir mensaje en la consola
	li $v0, 4
	la $a0, cad
	syscall
	
	jr $ra