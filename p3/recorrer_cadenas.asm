	#-- Ejemplo de recorrer una cadena
	.data
	
cad: 	.space 1024			## Reservo el espacio para la cadena que nos va a pasar el usuario

	.text
	#-- Pedir al usuario que introduzca una cadena
	li $v0, 8
	la $a0, cad
	li $a1, 1024
	syscall
	
	#-- s0: puntero a la cadena
	#-- s1: carácter actual
	la $s0, cad
	
repetir:
	#-- Leer el carácter (byte) de la cadena
	lb $s1, 0($s0)
	
	#-- Imprimir el carácter
	li $v0, 11
	move $a0, $s1
	syscall
	
	#-- Si llega al final de la cadena, terminar
	beq $s1, '\n', fin
	
	#-- Incrementar el puntero
	addi $s0, $s0, 1
	
	#-- Repetir
	b repetir
	
	
fin:	li $v0, 10
	syscall