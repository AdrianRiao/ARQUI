	#-- Convertir una cadena a numeros
	.data
cad:	.space 1024
	
	.text
	#-- Pedir la cadena al usuario
	li $v0, 8
	la $a0, cad
	li $a1, 1024
	syscall
	
	#-- Puntero a la cadena --> s0
	la $s0, cad
	
	#-- num --> s1
	li $s1, 0

repetir:
	#-- car --> s2
	lb $s2, 0($s0)
	beq $s2, '\n', fin
	
	#-- si car es \n, terminar
	
	#-- num = num * 10
	li $t0, 10
	mult  $s1, $t0				## Te deja el resultado de la mult en el registro lo
	mflo $s1				## Mueve el registro lo a $s1
	
	#-- num = num + (car - '0')
	subi $s2, $s2, '0'
	add $s1, $s1, $s2
	
	#-- Incrementar el puntero
	addi $s0, $s0, 1
	
	#-- repetir
	b repetir
	
	
fin:	
	li $v0, 10
	syscall
