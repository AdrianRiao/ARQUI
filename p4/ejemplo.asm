	.data
cad:	.asciiz "Saludos...\n"
	
	
	.text
	
	jal saludo1 #salta a la etiqueta y se guarda en $ra la dirección de retorno(sigiente instrucción)
	jal saludo1
	jal saludo1
	
	
	#--- Terminar
	li $v0, 10
	syscall
	
	
saludo1:
	#--- Imprimir mensaje en la consola
	li $v0, 4
	la $a0, cad
	syscall
	
	jr $ra  #en $ra se guarda la dirección de retorno, así que vuelvo a la dirección siguiente a la llamada