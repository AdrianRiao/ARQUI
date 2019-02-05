	#-- Imprimir los numeros del 1 al 10
	
	#-- Variable índice: i --> s1
	li $s1, 0
bucle:
	#-- i = i + 1
	addi $s1, $s1, 1
	
	#-- Print i
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	#-- si i=10, terminar
	li $t0, 10
	beq  $s1, $t0, fin
	
	#-- Repetir
	b bucle
	
	
	
fin:	li $v0, 10
	syscall
